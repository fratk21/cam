// ignore: library_prefixes
import 'dart:math' as Math;

class StatikService {
  static double calculatePressure(double force, double area) {
    if (area == 0) return 0;
    return force / area;
  }

  static double calculateBendingStress(double moment, double sectionModulus) {
    if (sectionModulus <= 0) return 0;
    return moment / sectionModulus;
  }

  static double calculateShearStress(double shearForce, double area) {
    if (area <= 0) return 0;
    return shearForce / area;
  }

  static double calculateTensileStress(double force, double area) {
    if (area <= 0) return 0;
    return force / area;
  }

  static double calculateBeamReinforcement(
      double momentKNm, double effectiveDepthMm, double fyd) {
    if (effectiveDepthMm <= 0 || fyd <= 0) return 0;
    double momentNmm = momentKNm * 1e6;
    return momentNmm / (0.9 * effectiveDepthMm * fyd);
  }

  static double calculateSlabReinforcement(
      double momentKNm, double effectiveDepthMm, double fyd) {
    if (effectiveDepthMm <= 0 || fyd <= 0) return 0;
    double momentNmm = momentKNm * 1e6;
    return momentNmm / (0.9 * effectiveDepthMm * fyd);
  }

  static double calculateSquareFoundationSize(
      double loadKN, double soilBearingKNm2) {
    if (soilBearingKNm2 <= 0) return 0;
    double area = loadKN / soilBearingKNm2;
    return area > 0 ? Math.sqrt(area) : 0;
  }

  static double calculateConcreteVolume(double areaM2, double thicknessM) {
    if (areaM2 <= 0 || thicknessM <= 0) return 0;
    return areaM2 * thicknessM;
  }

  static double calculateRebarTonnage(
      double crossSectionAreaMm2, double lengthM) {
    double volumeCm3 = (crossSectionAreaMm2 / 100) * (lengthM * 100);
    double weightKg = volumeCm3 * 7.85;
    return weightKg / 1000; // ton
  }

  static double calculateFormworkArea(double lengthM, double heightM) {
    if (lengthM <= 0 || heightM <= 0) return 0;
    return lengthM * heightM;
  }

  static double calculateLabourCost(double quantity, double unitPrice) {
    if (quantity <= 0 || unitPrice <= 0) return 0;
    return quantity * unitPrice;
  }

  static double calculateSteelBarWeight(double diameterMm, double lengthM) {
    double areaCm2 = Math.pi * Math.pow(diameterMm / 10 / 2, 2);
    double weightKg = areaCm2 * lengthM * 7.85;
    return weightKg;
  }

  static double calculateSlopedRoofArea(double baseAreaM2, double slopeDegree) {
    double slopeRadian = slopeDegree * Math.pi / 180;
    return baseAreaM2 / Math.cos(slopeRadian);
  }

  static Map<String, double> calculateConcreteMix(
      double volumeM3, String grade) {
    double cement;
    double sand;
    double gravel;
    double water;

    if (grade == "C20") {
      cement = 320;
      sand = 660;
      gravel = 1200;
      water = 160;
    } else if (grade == "C25") {
      cement = 340;
      sand = 650;
      gravel = 1250;
      water = 165;
    } else {
      cement = 0;
      sand = 0;
      gravel = 0;
      water = 0;
    }

    return {
      "Çimento (kg)": cement * volumeM3,
      "Kum (kg)": sand * volumeM3,
      "Çakıl (kg)": gravel * volumeM3,
      "Su (kg)": water * volumeM3,
    };
  }

  static double calculateSafeSlopeAngle(double soilTypeFactor) {
    return soilTypeFactor; // Örnek: Kumlu zemin 30°, kil 45°
  }

  static double convertUnit(
      double value, String from, String to, double materialDensityKgM3) {
    if (from == "m³" && to == "kg") return value * materialDensityKgM3;
    if (from == "m³" && to == "ton") {
      return (value * materialDensityKgM3) / 1000;
    }
    if (from == "kg" && to == "m³") return value / materialDensityKgM3;
    if (from == "ton" && to == "m³") {
      return (value * 1000) / materialDensityKgM3;
    }
    if (from == "litre" && to == "m³") return value / 1000;
    if (from == "m³" && to == "litre") return value * 1000;
    return 0;
  }

  static double recommendColumnSize(double loadKN, double concreteStrengthMpa) {
    double areaCm2 = (loadKN * 1000) / (0.5 * concreteStrengthMpa * 1e1);
    return Math.sqrt(areaCm2);
  }
}
