import 'package:flutter/material.dart';

class ProdutoCard extends StatelessWidget {
  final String nome;
  final String descricao;
  final double preco;
  final IconData icone;

  const ProdutoCard({
    super.key,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icone,
              size: 60,
              color: Colors.grey,
            ),
            Text(
              nome,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              descricao,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            Text(
              'R\$ ${preco.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
              ),
              child: const Text(
                'Comprar',
                style: TextStyle(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}