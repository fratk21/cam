import 'package:cam/ui/pages/BeamQuickAnalysisPage.dart';
import 'package:cam/ui/pages/ColumnOptimizationPage.dart';
import 'package:cam/ui/pages/ColumnReinforcementPage.dart';
import 'package:cam/ui/pages/ConcreteMixPage.dart';
import 'package:cam/ui/pages/ConcreteWaterCementPage.dart';
import 'package:cam/ui/pages/ElevatorPitPage.dart';
import 'package:cam/ui/pages/FormworkAreaPage.dart';
import 'package:cam/ui/pages/LabourCostPage.dart';
import 'package:cam/ui/pages/LevelMeterPage.dart';
import 'package:cam/ui/pages/LightMeterPage.dart';
import 'package:cam/ui/pages/MaterialConverterPage.dart';
import 'package:cam/ui/pages/RoofDrainagePage.dart';
import 'package:cam/ui/pages/SafeSlopePage.dart';
import 'package:cam/ui/pages/SlabReinforcementPage.dart';
import 'package:cam/ui/pages/SlopedRoofAreaPage.dart';
import 'package:cam/ui/pages/SlopedRoofMaterialPage.dart';
import 'package:cam/ui/pages/SquareFoundationPage.dart';
import 'package:cam/ui/pages/StairDesignPage.dart';
import 'package:cam/ui/pages/UnitConverterPage.dart';
import 'package:flutter/material.dart';
import 'package:cam/ui/pages/SteelBarWeightPage.dart';
import 'package:cam/ui/pages/beton_hacim_page.dart';
import 'package:cam/ui/pages/cekme_gerilme_page.dart';
import 'package:cam/ui/pages/demir_tonaj_page.dart';
import 'package:cam/ui/pages/kesme_gerilme_page.dart';
import 'package:cam/ui/pages/kiris_donati_page.dart';
import 'package:cam/ui/pages/kiris_egilme_page.dart';
import 'package:cam/ui/pages/kolon_basinc_page.dart';
import 'package:cam/ui/pages/SlopedRoofMaterialPage.dart';

// Eksik modüller importları ekle

class HomePage extends StatelessWidget {
  Widget buildSectionTitle(String title, String subtitle, IconData icon) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.blueGrey[900],
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: TextStyle(fontSize: 20, color: Colors.white)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  Widget buildAppTile(
      BuildContext context, String title, Widget page, IconData icon) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue[700]),
        title: Text(title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(
          "İnşaat Hesap Pro",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1,
              color: Colors.white),
        ),
        centerTitle: true,
        leading: Icon(Icons.construction, color: Colors.white),
      ),
      body: ListView(
        children: [
          buildSectionTitle("Statik Hesaplar",
              "Kolon, kiriş, çekme, kesme gerilmesi", Icons.account_balance),
          buildAppTile(context, "Kolon Basınç Hesabı", KolonBasincPage(),
              Icons.vertical_align_bottom),
          buildAppTile(context, "Kiriş Eğilme Hesabı", KirisEgilmePage(),
              Icons.straighten),
          buildAppTile(context, "Kesme Gerilmesi Hesabı", KesmeGerilmePage(),
              Icons.content_cut),
          buildAppTile(context, "Çekme Gerilmesi Hesabı", CekmeGerilmePage(),
              Icons.call_split),
          buildSectionTitle("Betonarme Hesaplar",
              "Donatı, beton, kalıp, işçilik hesapları", Icons.build),
          buildAppTile(context, "Kiriş Donatı Hesabı", KirisDonatiPage(),
              Icons.recycling),
          buildAppTile(context, "Döşeme Donatı Hesabı", SlabReinforcementPage(),
              Icons.border_all),
          buildAppTile(context, "Kare Temel Boyutlandırma",
              SquareFoundationPage(), Icons.view_module),
          buildAppTile(context, "Kalıp Alanı Hesabı", FormworkAreaPage(),
              Icons.square_foot),
          buildAppTile(context, "İşçilik Maliyeti Hesabı", LabourCostPage(),
              Icons.attach_money),
          buildAppTile(context, "Beton Hacmi Hesabı", BetonHacimPage(),
              Icons.cloud_queue),
          buildAppTile(context, "Demir Tonaj Hesabı", DemirTonajPage(),
              Icons.line_weight),
          buildAppTile(context, "Çubuk Çelik Ağırlık Hesabı",
              SteelBarWeightPage(), Icons.linear_scale),
          buildSectionTitle("Akıllı Saha Modülleri",
              "Gelişmiş saha destek hesapları", Icons.smart_toy),
          buildAppTile(context, "Eğimli Çatı Alanı Hesabı",
              SlopedRoofAreaPage(), Icons.roofing),
          buildAppTile(context, "Beton Karışım Hesabı (C20-C25)",
              ConcreteMixPage(), Icons.blender),
          buildAppTile(context, "Şev Açısı Basit Stabilite", SafeSlopePage(),
              Icons.terrain),
          buildAppTile(
              context, "Birim Dönüştürücü", UnitConverterPage(), Icons.cached),
          buildAppTile(context, "Kolon Boyut Optimizasyonu",
              ColumnOptimizationPage(), Icons.auto_awesome),
          buildSectionTitle("İleri Saha Modülleri",
              "Hesap makinesiyle yapılamayanlar", Icons.science),
          buildAppTile(context, "Şev Stabilite Faktörü", SlopeStabilityPage(),
              Icons.line_style),
          buildAppTile(context, "Beton Karışımı + Su/Çimento Oranı",
              ConcreteWaterCementPage(), Icons.opacity),
          buildAppTile(context, "Kolon Donatı Önerisi",
              ColumnReinforcementPage(), Icons.shield),
          buildAppTile(context, "Malzeme Dönüştürücü + Fire",
              MaterialConverterPage(), Icons.compare_arrows),
          buildAppTile(context, "Kiriş Eğilme/Kesme Analizi",
              BeamQuickAnalysisPage(), Icons.analytics),
          buildAppTile(context, "Çatı Drenaj Hesabı", RoofDrainagePage(),
              Icons.water_drop),
          buildAppTile(context, "Asansör Kuyu Hesabı", ElevatorPitPage(),
              Icons.elevator),
          buildAppTile(context, "Merdiven Basamak Hesabı", StairDesignPage(),
              Icons.stairs),
          buildSectionTitle(
              "Saha Araçları",
              "Su terazisi, ışık, ölçüm destekleri",
              Icons.precision_manufacturing),
          buildAppTile(context, "Düzlük Ölçer (Su Terazisi)", LevelMeterPage(),
              Icons.straighten),
          buildAppTile(
              context, "Işık Ölçer (Lux)", LightMeterPage(), Icons.wb_sunny),
        ],
      ),
    );
  }
}
