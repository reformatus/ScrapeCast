import 'package:html/dom.dart';

import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:xml/xml.dart' as xml;
import 'package:intl/intl.dart';

import '../utils/types.dart';

Map<String, String?> marcoPages = {
  //! Ószövetség
  ...{
    "Bibliamagyarázat - Mózes első könyve":
        "https://marko.reformatus.hu/Moz1.shtml",
    "Bibliamagyarázat - Mózes második könyve":
        "https://marko.reformatus.hu/2Moz.shtml",
    "Bibliamagyarázat - Mózes harmadik könyve":
        "https://marko.reformatus.hu/3Moz.shtml",
    "Bibliamagyarázat - Mózes negyedik könyve":
        "https://marko.reformatus.hu/4Moz.shtml",
    "Bibliamagyarázat - Mózes ötödik könyve":
        "https://marko.reformatus.hu/5Moz.shtml",
    "Bibliamagyarázat - Józsué könyve": null,
    "Bibliamagyarázat - A bírák könyve": null,
    "Bibliamagyarázat - Ruth könyve": "https://marko.reformatus.hu/Ruth.shtml",
    "Bibliamagyarázat - Sámuel első könyve":
        "https://marko.reformatus.hu/Sam1.shtml",
    "Bibliamagyarázat - Sámuel második könyve":
        "https://marko.reformatus.hu/Sam2.shtml",
    "Bibliamagyarázat - A királyok első könyve": null,
    "Bibliamagyarázat - A királyok második könyve":
        "https://marko.reformatus.hu/2Kir.shtml",
    "Bibliamagyarázat - A krónikák első könyve": null,
    "Bibliamagyarázat - A krónikák második könyve": null,
    "Bibliamagyarázat - Ezsdrás könyve": null,
    "Bibliamagyarázat - Nehémiás könyve": null,
    "Bibliamagyarázat - Eszter könyve":
        "https://marko.reformatus.hu/Eszter.shtml",
    "Bibliamagyarázat - Jób könyve": null,
    "Bibliamagyarázat - A zsoltárok könyve":
        "https://marko.reformatus.hu/Zsolt.shtml",
    "Bibliamagyarázat - A példabeszédek könyve":
        "https://marko.reformatus.hu/Peld.shtml",
    "Bibliamagyarázat - A prédikátor könyve": null,
    "Bibliamagyarázat - Énekek éneke": null,
    "Bibliamagyarázat - Ézsaiás próféta könyve":
        "https://marko.reformatus.hu/Ezs.shtml",
    "Bibliamagyarázat - Jeremiás próféta könyve": null,
    "Bibliamagyarázat - Jeremiás siralmai": null,
    "Bibliamagyarázat - Ezékiel próféta könyve":
        "https://marko.reformatus.hu/Ez.shtml",
    "Bibliamagyarázat - Dániel próféta könyve":
        "https://marko.reformatus.hu/Dan.shtml",
    "Bibliamagyarázat - Hóseás próféta könyve": null,
    "Bibliamagyarázat - Jóel próféta könyve": null,
    "Bibliamagyarázat - Ámósz próféta könyve":
        "https://marko.reformatus.hu/Amosz.shtml",
    "Bibliamagyarázat - Abdiás próféta könyve": null,
    "Bibliamagyarázat - Jónás próféta könyve": null,
    "Bibliamagyarázat - Mikeás próféta könyve":
        "https://marko.reformatus.hu/Mikeas.shtml",
    "Bibliamagyarázat - Náhum próféta könyve":
        "https://marko.reformatus.hu/Nahum.shtml",
    "Bibliamagyarázat - Habakuk próféta könyve": null,
    "Bibliamagyarázat - Zofóniás próféta könyve": null,
    "Bibliamagyarázat - Haggeus próféta könyve":
        "https://marko.reformatus.hu/Hag.shtml",
    "Bibliamagyarázat - Zakariás próféta könyve": null,
    "Bibliamagyarázat - Malakiás próféta könyve":
        "https://marko.reformatus.hu/Mal.shtml",
  },
  //! Újszövetség
  ...{
    "Bibliamagyarázat - Máté evangéliuma":
        "https://marko.reformatus.hu/Mate.shtml",
    "Bibliamagyarázat - Márk evangéliuma":
        "https://marko.reformatus.hu/Mark.shtml",
    "Bibliamagyarázat - Lukács evangéliuma":
        "https://marko.reformatus.hu/Lk.shtml",
    "Bibliamagyarázat - János evangéliuma":
        "https://marko.reformatus.hu/Janos.shtml",
    "Bibliamagyarázat - Az apostolok cselekedetei":
        "https://marko.reformatus.hu/ApCsel.shtml",
    "Bibliamagyarázat - Pál levele a rómaiakhoz":
        "https://marko.reformatus.hu/Roma.shtml",
    "Bibliamagyarázat - Pál első levele a korinthusiakhoz":
        "https://marko.reformatus.hu/1Kor.shtml",
    "Bibliamagyarázat - Pál második levele a korinthusiakhoz":
        "https://marko.reformatus.hu/2Kor.shtml",
    "Bibliamagyarázat - Pál levele a galatákhoz":
        "https://marko.reformatus.hu/Gal.shtml",
    "Bibliamagyarázat - Pál levele az efezusiakhoz":
        "https://marko.reformatus.hu/Efezus.shtml",
    "Bibliamagyarázat - Pál levele a filippiekhez":
        "https://marko.reformatus.hu/Fil.shtml",
    "Bibliamagyarázat - Pál levele a kolosséiakhoz":
        "https://marko.reformatus.hu/Kol.shtml",
    "Bibliamagyarázat - Pál első levele a thesszalonikaiakhoz":
        "https://marko.reformatus.hu/1Thessz.shtml",
    "Bibliamagyarázat - Pál második levele a thesszalonikaiakhoz":
        "https://marko.reformatus.hu/2Thessz.shtml",
    "Bibliamagyarázat - Pál első levele Timóteushoz":
        "https://marko.reformatus.hu/1Tim.shtml",
    "Bibliamagyarázat - Pál második levele Timóteushoz":
        "https://marko.reformatus.hu/2Tim.shtml",
    "Bibliamagyarázat - Pál levele Tituszhoz":
        "https://marko.reformatus.hu/Titusz.shtml",
    "Bibliamagyarázat - Pál levele Filemonhoz":
        "https://marko.reformatus.hu/Filem.shtml",
    "Bibliamagyarázat - A zsidókhoz írt levél":
        "https://marko.reformatus.hu/Zsid.shtml",
    "Bibliamagyarázat - Jakab levele":
        "https://marko.reformatus.hu/Jakab.shtml",
    "Bibliamagyarázat - Péter első levele":
        "https://marko.reformatus.hu/1Pt.shtml",
    "Bibliamagyarázat - Péter második levele":
        "https://marko.reformatus.hu/2Pt.shtml",
    "Bibliamagyarázat - János első levele":
        "https://marko.reformatus.hu/1Janos.shtml",
    "Bibliamagyarázat - János második levele":
        "https://marko.reformatus.hu/2Janos.shtml",
    "Bibliamagyarázat - János harmadik levele":
        "https://marko.reformatus.hu/3Janos.shtml",
    "Bibliamagyarázat - Júdás levele":
        "https://marko.reformatus.hu/Judas.shtml",
    "Bibliamagyarázat - A jelenések könyve":
        "https://marko.reformatus.hu/Jel.shtml",
  },
  //! Tematikus / Vallásismeret
  ...{
    "Vallásismeret - Apostoli hitvallás":
        "https://marko.reformatus.hu/ApostoliHitvallas.shtml",
    "Vallásismeret - Bibliaismeret":
        "https://marko.reformatus.hu/Bibliaismeret.shtml",
    "Vallásismeret - Egyháztan": "https://marko.reformatus.hu/Egyhaztan.shtml",
    "Vallásismeret - Heidelbergi Káté":
        "https://marko.reformatus.hu/HeidelbergiKT.shtml",
    "Vallásismeret - Keresztyén élet":
        "https://marko.reformatus.hu/Kerelet.shtml",
    "Vallásismeret - Pünkösdre készülve":
        "https://marko.reformatus.hu/Punkosd.shtml",
    "Vallásismeret - Sákramentumok":
        "https://marko.reformatus.hu/Sakramentumok.shtml",
    "Vallásismeret - Tanítványság":
        "https://marko.reformatus.hu/Tanitvanysag.shtml",
  },
  //! Tematikus / Képzés
  ...{
    "Lelkészképzés": "https://marko.reformatus.hu/Lelkeszkepzes.shtml",
    "Misszióképzés": "https://marko.reformatus.hu/Misszio.shtml",
    "Pedagógusképzés": "https://marko.reformatus.hu/Pedagoguskepzes.shtml",
    "Presbiterképzés": "https://marko.reformatus.hu/Presbiterkepzes.shtml",
    "Szülők iskolája": "https://marko.reformatus.hu/Szulok.shtml",
  },
  //! Tematikus / Egyéb
  ...{
    "Áhítat": "https://marko.reformatus.hu/Ahitat.shtml",
    "Bizonyságtétel": "https://marko.reformatus.hu/Biztetel.shtml",
    "Evangelizáció": "https://marko.reformatus.hu/Evang.shtml",
    "Ismeretterjesztés": "https://marko.reformatus.hu/Ismeretterjesztes.shtml",
  }
};

void main() async {
  var list = await marcoScraper();
  print(list.length);
  print("end");
}

Future<List<Episode>> marcoScraper() async {
  await initializeDateFormatting('hu_HU', null);
  var httpClient = Client();

  print('Scraping latest from marko.reformatus.hu');

  List<Episode> episodes = [];

  for (MapEntry<String, String?> pageLink in marcoPages.entries) {
    if (pageLink.value == null) continue;
    print('  Scraping $pageLink');

    List<Episode> pageEpisodes = [];

    var resp = await httpClient.get(
      Uri.parse(pageLink.value!),
    );
    var document = parse(resp.body);

    var rows = document
        .querySelectorAll("##object > table > tbody > tr")
        .where((element) =>
            ((element.nodes.first.nodes.first as Element).localName == "a"))
        .toList();

    String errorsOnPage = "";

    for (var row in rows) {
      String errorsInRow = "";

      String? title = row.nodes[0].text;
      if (title == null) errorsInRow += "\nCouldn't extract title";

      String? dateString = row.nodes[1].text;
      if (dateString == null) errorsInRow += "\nCouldn't extract date";
      DateTime? date;
      try {
        date = (dateString == null)
            ? null
            : DateFormat('y. MMMM d.', 'hu_HU').parse(dateString);
      } catch (e) {
        try {
          date = (dateString == null)
              ? null
              : DateFormat('y MMMM d.', 'hu_HU').parse(dateString);
        } catch (e) {
          errorsInRow += "\nCouldn't parse date: $e";
        }
      }
      if (date == null) errorsInRow += "\nCouldn't parse date";

      String? place = row.nodes[2].text;
      if (place == null) errorsInRow += "\nCouldn't extract place";

      String? fileString =
          (row.firstChild != null && row.firstChild!.firstChild != null)
              ? (row.firstChild!.firstChild!.attributes['href'])
              : null;
      if (fileString == null) errorsInRow += "\nCouldn't extract file link";
      Uri? file = Uri.parse("${pageLink.value!}/$fileString");
      if (file == null) errorsInRow += "\nCouldn't parse file link";

      if (errorsInRow.isNotEmpty) {
        errorsOnPage +=
            "\n  Error(s) occured while reading line ${row.text}:$errorsInRow\n  Skipping.\n";
        continue;
      }

      pageEpisodes.add(Episode(PodcastID.marco, date!, title!, "", place, null,
          file.toString(), file.hashCode.toString(), null, null));
    }

    if (errorsOnPage.isNotEmpty) print(errorsOnPage);
    print('    Got ${pageEpisodes.length} episodes.\n');
    episodes.addAll(pageEpisodes);
  }

  return episodes;
}

Episode marcoFromJson(Map entry) => Episode(
    PodcastID.krek,
    dateFormat.parse(entry["date"]),
    entry["title"],
    entry["author"],
    null,
    entry["youtube"],
    entry["download"],
    entry["uuid"],
    entry["length"],
    entry["size"]);

Map marcoToJson(Episode episode) => {
      "title": episode.title,
      "date": dateFormat.format(episode.date),
      "author": episode.author,
      "youtube": episode.field2,
      "download": episode.download,
      "uuid": episode.uuid,
      "length": episode.length,
      "size": episode.fileSize,
    };

String marcoTitleBuilder(Episode element) =>
    '${element.title} | ${element.author} | ${dateFormat.format(element.date)}';

String marcoDescriptionBuilder(Podcast podcast, Episode element) {
  xml.XmlBuilder builder = xml.XmlBuilder();

  if (element.field2 != null) {
    builder.element('p', nest: () {
      builder.element('a', attributes: {"href": element.field2!}, nest: () {
        builder.text('A podcast YouTube-on is elérhető: ${element.field2}');
      });
    });
  }

  builder.element('br', isSelfClosing: true);

  builder.element('p', nest: () {
    builder.text('Szereplők: ${element.author}');
  });

  builder.element('br', isSelfClosing: true);
  builder.element('hr', isSelfClosing: true);

  builder.element('p', nest: () {
    builder.text('Lejátszás közvetlen fájlból (hiba esetén): ');
    builder.element('a',
        attributes: {"href": podcast.properties.baseUrl + element.download},
        nest: () {
      builder.text(podcast.properties.baseUrl + element.download);
    });
  });

  builder.element('br', isSelfClosing: true);

  builder.element('p', nest: () {
    builder.text('Becsült hossz: ${element.length} mp');
  });
  builder.element('p', nest: () {
    builder.text('Generálta: ');
    builder.element('a',
        attributes: {"href": "https://reformatus.github.io/scrapecast"},
        nest: () {
      builder.text('ScrapeCast');
    });
    builder.text(' by Fodor Benedek');
  });
  builder.element('p', nest: () {
    builder.text('UUID: ${element.uuid}');
  });

  return builder
      .buildDocument()
      .toXmlString(pretty: true, preserveWhitespace: (_) => true);
}
