import 'package:candi/data.dart';
import 'package:candi/detail.dart';
import 'package:flutter/material.dart';

import 'item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = "Borobudur";
  String image = "assets/images/borobudur.jpg";
  String description =
      '''Dinasti Sailendra membangun peninggalan Budha terbesar di dunia antara 780-840 Masehi. Dinasti Sailendra merupakan dinasti yang berkuasa pada masa itu. Peninggalan ini dibangun sebagai tempat pemujaan Budha dan tempat ziarah. Tempat ini berisi petunjuk agar manusia menjauhkan diri dari nafsu dunia dan menuju pencerahan dan kebijaksanaan menurut Buddha. Peninggalan ini ditemukan oleh Pasukan Inggris pada tahun 1814 dibawah pimpinan Sir Thomas Stanford Raffles. Area candi berhasil dibersihkan seluruhnya pada tahun 1835.

Borobudur dibangun dengan gaya Mandala yang mencerminkan alam semesta dalam kepercayaan Buddha. Struktur bangunan ini berbentuk kotak dengan empat pintu masuk dan titik pusat berbentuk lingkaran. Jika dilihat dari luar hingga ke dalam terbagi menjadi dua bagian yaitu alam dunia yang terbagi menjadi tiga zona di bagian luar, dan alam Nirwana di bagian pusat.
''';

  bool isSearch = false;
  TextEditingController controller = TextEditingController();

  List<Item>? search;
  @override
  void initState() {
    search = item;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: isSearch ? const Icon(Icons.search) : const SizedBox(),
        title: isSearch
            ? TextField(
                controller: controller,
                onChanged: (val) {
                  setState(() {
                    search = item
                        .where((element) =>
                            element.title.toLowerCase().contains(val))
                        .toList();
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: "Ketik nama candi ...",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
                cursorColor: Colors.white,
              )
            : const Text("7 Candi Indonesia"),
        centerTitle: true,
        backgroundColor: const Color(0xFF066163),
        actions: [
          isSearch
              ? IconButton(
                  splashRadius: 20,
                  onPressed: () => setState(() {
                    isSearch = !isSearch;
                    search = item;
                    controller.clear();
                  }),
                  icon: const Icon(Icons.close_rounded),
                )
              : IconButton(
                  splashRadius: 20,
                  onPressed: () => setState(() {
                    isSearch = !isSearch;
                    search = [];
                  }),
                  icon: const Icon(Icons.search),
                ),
        ],
      ),
      body: Center(
        child: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? ListView.builder(
                itemCount: search!.length,
                itemBuilder: (context, index) {
                  final queryText =
                      search![index].title.substring(0, controller.text.length);
                  final remainingText =
                      search![index].title.substring(controller.text.length);
                  return ListTile(
                    leading: Hero(
                      tag: search![index].title,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          search![index].image,
                        ),
                      ),
                    ),
                    title: isSearch
                        ? Text.rich(
                            TextSpan(
                              text: queryText,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: remainingText,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Text(
                            item[index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailItem(
                          image: search![index].image,
                          title: search![index].title,
                          description: search![index].description,
                        ),
                      ),
                    ),
                  );
                })
            : Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: search!.length,
                        itemBuilder: (context, index) {
                          final queryText = search![index]
                              .title
                              .substring(0, controller.text.length);
                          final remainingText = search![index]
                              .title
                              .substring(controller.text.length);

                          return ListTile(
                            leading: Hero(
                              tag: search![index].title,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  search![index].image,
                                ),
                              ),
                            ),
                            title: isSearch
                                ? Text.rich(
                                    TextSpan(
                                      text: queryText,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: remainingText,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Text(
                                    search![index].title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                            onTap: () {
                              setState(() {
                                image = search![index].image;
                                title = search![index].title;
                                description = search![index].description;
                              });
                            },
                          );
                        }),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: const Color.fromARGB(255, 228, 228, 228),
                      child: ListView(
                        children: [
                          Hero(
                            tag: title,
                            child: SizedBox(
                              width: size.width,
                              height: size.height * 0.4,
                              child: Image.asset(
                                image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            child: Text(
                              description,
                              textAlign: TextAlign.justify,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
