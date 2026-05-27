import 'package:app_autenticacao/product_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString('userName') ?? '';
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  final List<Map<String, dynamic>> produtos = [
    {
      "nome": "Notebook",
      "descricao": "Notebook 15\" com processador Intel i7",
      "preco": 3500.0,
      "icone": Icons.laptop,
    },
    {
      "nome": "Celular",
      "descricao": "Smartphone Android com 128GB",
      "preco": 2000.0,
      "icone": Icons.phone_android,
    },
    {
      "nome": "Headset",
      "descricao": "Headset gamer com som surround",
      "preco": 250.0,
      "icone": Icons.headphones,
    },
    {
      "nome": "Mouse Gamer",
      "descricao": "Mouse RGB com 6 botões",
      "preco": 120.0,
      "icone": Icons.mouse,
    },
    {
      "nome": "Teclado",
      "descricao": "Teclado mecânico RGB",
      "preco": 300.0,
      "icone": Icons.keyboard,
    },
    {
      "nome": "Monitor",
      "descricao": "Monitor Full HD 24 polegadas",
      "preco": 950.0,
      "icone": Icons.monitor,
    },
    {
      "nome": "Smartwatch",
      "descricao": "Relógio inteligente esportivo",
      "preco": 450.0,
      "icone": Icons.watch,
    },
    {
      "nome": "Câmera",
      "descricao": "Câmera digital profissional",
      "preco": 2800.0,
      "icone": Icons.camera_alt,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loja Online'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userName.isEmpty ? 'Login realizado' : 'Olá, $userName',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              const Text(
                'Bem vindo',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Expanded(
                child: GridView.builder(
                  itemCount: produtos.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.60,
                  ),
                  itemBuilder: (context, index) {
                    return ProdutoCard(
                      nome: produtos[index]['nome'],
                      descricao: produtos[index]['descricao'],
                      preco: produtos[index]['preco'],
                      icone: produtos[index]['icone'],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
