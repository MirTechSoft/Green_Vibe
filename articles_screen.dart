import 'package:flutter/material.dart';

class ArticlesScreen extends StatelessWidget {
  final List<Map<String, String>> articles = [
    {
      'title': 'Sustainability in Everyday Life',
      'summary': 'How small habits contribute to big change.',
      'content':
          'Sustainability in everyday life means making choices that reduce our impact on the planet. Small habits like using reusable bags, conserving water, and reducing energy consumption can lead to significant positive environmental changes over time.', 
      "image": "assets/images/public_transport.jpg",
    },
    {
      'title': 'Reducing Plastic Waste',
      'summary': 'Tips and tricks for a plastic-free lifestyle.',
      'content':
          'Reducing plastic waste is crucial to protect wildlife and reduce pollution. You can start by avoiding single-use plastics, opting for alternatives like glass or metal containers, and participating in local clean-up activities.',
      "image": "assets/images/plasticfree.jpg",
    },
    {
      'title': 'Climate Change Facts',
      'summary': 'Understand the science and impacts.',
      'content':
          'Climate change refers to significant changes in global temperatures and weather patterns. It is largely caused by human activities like burning fossil fuels and deforestation, leading to rising sea levels, extreme weather events, and biodiversity loss.',
          // 
      "image": "assets/images/climate_change.jpg",
    },
    {
      'title': 'Renewable Energy Sources',
      'summary': 'A beginner’s guide to solar, wind, and more.',
      'content':
          'Renewable energy comes from natural sources that are constantly replenished. Solar panels, wind turbines, and hydropower are some popular renewable energy technologies helping reduce carbon footprint.',
      "image": "assets/images/renewable_energy.jpg",
    },
    {
      'title': 'Conserving Water at Home',
      'summary': 'Easy steps to reduce water waste.',
      'content':
          'Water conservation can be done by fixing leaks, using water-efficient fixtures, and being mindful of daily water use. Saving water reduces the energy needed for water treatment and distribution.',
      "image": "assets/images/water_conservation.jpg",
    },
  ];

  ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Articles',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];

          return GestureDetector(
            onTap: () => _openArticleDetail(context, article),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Hero(
                    tag: article['title'] ?? '',
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(14),
                        bottomLeft: Radius.circular(14),
                      ),
                      child: _safeImageAsset(
                        article['image'],
                        width: 110,
                        height: 110,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article['title'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            article['summary'] ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Read more",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.green.shade700,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Colors.green.shade700,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _safeImageAsset(String? path, {double? width, double? height}) {
    final safePath = (path != null && path.isNotEmpty)
        ? path
        : 'assets/images/placeholder.jpg';

    return Image.asset(
      safePath,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey.shade300,
          child: const Icon(Icons.broken_image, color: Colors.grey),
        );
      },
    );
  }

  void _openArticleDetail(BuildContext context, Map<String, String> article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ArticleDetailScreen(
          title: article['title'] ?? '',
          content: article['content'] ?? '',
          image: article['image'] ?? 'assets/images/placeholder.jpg',
        ),
      ),
    );
  }
}

class ArticleDetailScreen extends StatelessWidget {
  final String title;
  final String content;
  final String image;

  const ArticleDetailScreen({
    super.key,
    required this.title,
    required this.content,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: title,
              child: _safeImageAsset(
                image,
                width: double.infinity,
                height: 220,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                content,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _safeImageAsset(String? path, {double? width, double? height}) {
    final safePath = (path != null && path.isNotEmpty)
        ? path
        : 'assets/images/placeholder.jpg';

    return Image.asset(
      safePath,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey.shade300,
          child: const Icon(Icons.broken_image, size: 50),
        );
      },
    );
  }
}
