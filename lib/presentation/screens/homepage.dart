import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passguardian/utils/shared_preferences.dart';
import '../../storageservice.dart';
import 'settingspage.dart';
import 'storagescreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntriesFromLocal();
  }

  Future<void> _loadEntriesFromLocal() async {
    List<Map<String, String>> loadedEntries =
        await StorageService.loadEntriesFromLocal();
    setState(() {
      entries = loadedEntries;
    });
  }

  Future<void> _saveEntriesToLocal() async {
    // Remove entries with empty accountName to avoid saving deleted entries
    List<Map<String, String>> filteredEntries = entries
        .where((entry) => entry['accountName']?.isNotEmpty ?? false)
        .toList();
    await StorageService.saveEntriesToLocal(filteredEntries);
  }

  // Inside your _HomePageState class
  Future<void> addEntry(Map<String, String> newEntry) async {
    setState(() {
      entries.add(newEntry);
    });
    await _saveEntriesToLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'PassGuardian',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
              child: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(entries[index]['accountName']!),
            onDismissed: (direction) {
              // Remove the item from the entries list
              setState(
                () {
                  entries.removeAt(index);
                },
              );

              // Save entries to local storage after deletion
              _saveEntriesToLocal();

              // show a snackbar to undo the delete
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Item deleted"),
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      // Re-add the item to the list
                      setState(() {
                        entries.insert(index, entries[index]);

                        // Save entries to local storage after undo
                        _saveEntriesToLocal();
                      });
                    },
                  ),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                elevation: 1.0,
                child: ListTile(
                  title: Text(
                    'Account: ${entries[index]['accountName']}',
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Email: ${entries[index]['email']}',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      // Copy password to clipboard
                      String password = entries[index]['password'] ?? '';
                      Clipboard.setData(ClipboardData(text: password));

                      // Show a snackbar or any other feedback to indicate the copy action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password copied to clipboard"),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.copy,
                    ),
                  ),
                  onTap: () {
                    // Navigate to Storagescreen with pre-filled values
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StorageScreen(
                          accountName: entries[index]['accountName'],
                          email: entries[index]['email'],
                          password: entries[index]['password'],
                          notes: entries[index]['notes'],
                        ),
                      ),
                    ).then((result) {
                      // handle result if needed
                      if (result != null) {
                        // update the entries list if necessary
                        setState(() {
                          entries[index] = result;
                        });
                      }
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Map<String, String>? result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const StorageScreen()));

          if (result != null) {
            // ensure that the entry is a Map<String, String>
            Map<String, String> newEntry = {
              'accountName': result['accountName'] ?? '',
              'email': result['email'] ?? '',
              'password': result['password'] ?? '',
              'notes': result['notes'] ?? '',
            };

            // Update the entries list
            setState(() {
              entries.add(newEntry);
            });

            // Save entries to local storage
            await _saveEntriesToLocal();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
