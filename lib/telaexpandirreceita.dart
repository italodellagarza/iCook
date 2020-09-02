import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ICook/model/user.dart';

class TelaExpandirReceita extends StatelessWidget {
  TelaExpandirReceita(
      {Key key,
      this.receita,
      this.imageReference,
      this.imageReferenceUser,
      this.owner});
  final receita;
  final imageReference;
  final imageReferenceUser;
  final Usuario owner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("imgs/icon.png"), fit: BoxFit.fitHeight),
              ),
            ),
            SizedBox(width: 5),
            Text("iCook"),
          ],
        ),
        backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(imageReferenceUser != null
                      ? imageReferenceUser
                      : 'https://previews.123rf.com/images/dxinerz/dxinerz1508/dxinerz150800924/43773803-chef-cooking-cook-icon-vector-image-can-also-be-used-for-activities-suitable-for-use-on-web-apps-mob.jpg'),
                ),
                title: Text(owner.nome),
                subtitle: Text(owner.email),
                trailing: Icon(Icons.share),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Stack(
                  children: <Widget>[
                    imageReference != null
                        ? Container(
                            height: 200,
                            child: CachedNetworkImage(
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              imageUrl: imageReference,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          )
                        : Container(
                            constraints: BoxConstraints(
                              minHeight: 200,
                              maxHeight: 200,
                            ),
                            height: 250,
                            child: Center(
                                child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            ))),
                    SizedBox(),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.black.withOpacity(
                          0.50), // comment or change to transparent color
                      height: 50.0,
                      width: double.infinity,
                      child: Text(
                        receita["nome"],
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "Modo de Preparo",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(receita["modo_preparo"]),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "Rendimento",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(receita["rendimento"].toString()),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "Tempo de Preparo",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(receita["tempo_preparo"].toString()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
