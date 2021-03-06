import 'package:flutter/material.dart';
import 'package:snaptify/models/snaptify_response_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemTrack extends StatelessWidget {
  const ItemTrack({
    Key? key,
    required this.snaptifyData
  }) : super(key: key);

  final Data snaptifyData;



  String getSubString(String text){
    if(text.length > 30){
      return text.substring(0, 30) + "...";
    } else{
      return text;
    }
  }

  void _launchURL() async {
    if(snaptifyData.url != ""){
      if (!await launch(snaptifyData.url ?? "")) throw 'Could not launch ${snaptifyData.url}';
    }
  }

  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
            _launchURL();
        },
        child : Container(
          child : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children : [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child : CachedNetworkImage(
                  imageUrl: snaptifyData.image ?? "",

                  height: 64.0,
                  width: 64.0,
                  progressIndicatorBuilder: (context, url, progress) => Container(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      value: progress.progress,
                      color: Colors.black
                    ),
                    padding: EdgeInsets.all(16),
                    height: 64.0,
                    width: 64.0,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child :Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getSubString(snaptifyData.name ?? ""),
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                      )
                    ),
                    Text(getSubString(snaptifyData.artist ?? "")),
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}
