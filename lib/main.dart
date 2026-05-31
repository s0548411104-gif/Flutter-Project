import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'מדריך המדינות',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: CountrySearchScreen(),
      ),
    );
  }
}

class CountrySearchScreen extends StatefulWidget {
  const CountrySearchScreen({super.key});

  @override
  State<CountrySearchScreen> createState() => _CountrySearchScreenState();
}

class _CountrySearchScreenState extends State<CountrySearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic>? _countriesData;
  bool _isLoading = false;
  String _errorMessage = '';

  void _searchCountry() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _countriesData = null;
    });

    try {
      final data = await ApiService.fetchCountryData(_controller.text.trim());
      setState(() {
        _countriesData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'לא נמצאו נתונים. ודאי שכתבת באנגלית נכונה.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('חיפוש מידע על מדינות'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'הזיני שם מדינה באנגלית (למשל: Israel)',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _searchCountry,
                  ),
                ),
                onSubmitted: (_) => _searchCountry(),
              ),
            ),
            const SizedBox(height: 20),

            if (_isLoading)
              const CircularProgressIndicator()
            else if (_errorMessage.isNotEmpty)
              Text(_errorMessage, style: const TextStyle(color: Colors.red, fontSize: 16))
            else if (_countriesData != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: _countriesData!.length,
                    itemBuilder: (context, index) {
                      final country = _countriesData![index];

                      final commonName = country['name']?['common'] ?? 'אין שם';
                      final capital = (country['capital'] as List?)?.first ?? 'אין עיר בירה';
                      final population = country['population'] ?? 0;
                      final flagUrl = country['flags']?['png'] ?? '';
                      final region = country['region'] ?? 'אין נתון';
                      final isLandlocked = country['landlocked'] ?? false;
                      final landlockedText = isLandlocked ? 'כן (מדינה פנימית)' : 'לא (יש מוצא לים)';

                      String languages = 'אין נתון';
                      if (country['languages'] != null && country['languages'] is Map) {
                        languages = (country['languages'] as Map).values.join(', ');
                      }

                      String currencyText = 'אין נתון';
                      if (country['currencies'] != null && country['currencies'] is Map) {
                        final currenciesMap = country['currencies'] as Map;
                        if (currenciesMap.isNotEmpty) {
                          final firstCurrency = currenciesMap.values.first;
                          final curName = firstCurrency['name'] ?? '';
                          final curSymbol = firstCurrency['symbol'] ?? '';
                          currencyText = '$curName ($curSymbol)';
                        }
                      }

                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                commonName,
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const Divider(),
                              const SizedBox(height: 5),

                              _buildInfoRow('עיר בירה:', capital),
                              _buildInfoRow('יבשת:', region),
                              _buildInfoRow('שפות רשמיות:', languages),
                              _buildInfoRow('מטבע רשמי:', currencyText),
                              _buildInfoRow('מוקפת יבשה (ללא מוצא לים):', landlockedText),
                              _buildInfoRow(
                                  'אוכלוסייה:',
                                  population.toString().replaceAllMapped(
                                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},'
                                  )
                              ),

                              const SizedBox(height: 15),
                              if (flagUrl.isNotEmpty)
                                Center(
                                  child: Image.network(
                                    flagUrl,
                                    height: 120,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.flag, size: 50),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}