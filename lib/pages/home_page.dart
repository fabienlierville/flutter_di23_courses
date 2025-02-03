import 'package:flutter_di23_courses/models/Magasin.dart';
import 'package:flutter_di23_courses/utils/global_vars.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Magasins"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
              onPressed: (){
                upsert(null);
              },
              icon: Icon(Icons.add)
          )
        ],
      ),
    );
  }

  Future<void> upsert(Magasin? magasin) async {
    String? newMagasinNom = magasin?.nom ?? null;
    String? newMagasinVille = magasin?.ville ?? null;

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text('Ajouter un magasin'),
            content: Container(
              //On défini la hauteur car de base la colonne prend toute la hauteur
              height: MediaQuery.of(buildContext).size.height / 5,
              child: Column(
                children: [
                  TextField(
                    controller: TextEditingController(text:  magasin?.nom),
                    decoration: InputDecoration(
                        labelText: 'Nom Magasin:',
                        hintText: (magasin==null) ? 'ex: Leclerc' : magasin!.nom
                    ),
                    onChanged: (String str) {
                      newMagasinNom = str;
                    },
                  ),
                  TextField(
                    controller: TextEditingController(text:  magasin?.ville) ,
                    decoration: InputDecoration(
                        labelText: 'Ville Magasin:',
                        hintText: (magasin==null) ? 'ex: Rouen' : magasin!.ville
                    ),
                    onChanged: (String str) {
                      newMagasinVille = str;
                    },
                  ),
                ],
              ) ,
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(buildContext);
                },
                child: Text('Annuler'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
              ElevatedButton(
                onPressed: () {
                  if(newMagasinNom != null && newMagasinVille != null && GlobalVars.store != null){
                    if(magasin == null){
                      magasin = Magasin(nom: newMagasinNom!, ville: newMagasinVille!);
                    }else{
                      magasin!.nom = newMagasinNom!;
                      magasin!.ville = newMagasinVille!;
                    }
                    Box box = GlobalVars.store!.box<Magasin>();
                    int id = box.put(magasin);
                    print("=================== ${id} =======================");
                    Navigator.pop(buildContext);
                  }
                },
                child: Text('Valider'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              )
            ],
          );
        }
    );
  }

}
