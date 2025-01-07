// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// キャンセル
  internal static let alertCancel = L10n.tr("Localizable", "alert_cancel", fallback: "キャンセル")
  /// 削除する
  internal static let alertDelete = L10n.tr("Localizable", "alert_delete", fallback: "削除する")
  /// お知らせ
  internal static let alertNotify = L10n.tr("Localizable", "alert_notify", fallback: "お知らせ")
  /// 燃費情報を削除しますか？
  internal static let detailDeleteAlertTitle = L10n.tr("Localizable", "detail_delete_alert_title", fallback: "燃費情報を削除しますか？")
  /// 登録日
  internal static let detailEntryDay = L10n.tr("Localizable", "detail_entry_day", fallback: "登録日")
  /// ガソリン
  internal static let detailGasoline = L10n.tr("Localizable", "detail_gasoline", fallback: "ガソリン")
  /// 閉じる
  internal static let keyboardClose = L10n.tr("Localizable", "keyboard_close", fallback: "閉じる")
  /// 距離数で入力する
  internal static let nenpiCalcDistance = L10n.tr("Localizable", "nenpi_calc_distance", fallback: "距離数で入力する")
  /// メーターで計算する
  internal static let nenpiCalcMeter = L10n.tr("Localizable", "nenpi_calc_meter", fallback: "メーターで計算する")
  /// 終了メーター
  internal static let nenpiEndMeter = L10n.tr("Localizable", "nenpi_end_meter", fallback: "終了メーター")
  /// 登録
  internal static let nenpiEnrty = L10n.tr("Localizable", "nenpi_enrty", fallback: "登録")
  /// 広告を視聴すると
  /// 容量を増やすことができます。
  internal static let nenpiEnrtyLimitMsg = L10n.tr("Localizable", "nenpi_enrty_limit_msg", fallback: "広告を視聴すると\n容量を増やすことができます。")
  /// 登録上限に達しました
  internal static let nenpiEnrtyLimitTitle = L10n.tr("Localizable", "nenpi_enrty_limit_title", fallback: "登録上限に達しました")
  /// 燃費情報を登録しました。
  internal static let nenpiEnrtySuccessMsg = L10n.tr("Localizable", "nenpi_enrty_success_msg", fallback: "燃費情報を登録しました。")
  /// 走行距離
  internal static let nenpiMileage = L10n.tr("Localizable", "nenpi_mileage", fallback: "走行距離")
  /// 燃費
  internal static let nenpiNenpi = L10n.tr("Localizable", "nenpi_nenpi", fallback: "燃費")
  /// 料金
  internal static let nenpiPrice = L10n.tr("Localizable", "nenpi_price", fallback: "料金")
  /// 給油量
  internal static let nenpiRefuelingt = L10n.tr("Localizable", "nenpi_refuelingt", fallback: "給油量")
  /// 開始メーター
  internal static let nenpiStartMeter = L10n.tr("Localizable", "nenpi_start_meter", fallback: "開始メーター")
  /// 円
  internal static let priceAmountUnit = L10n.tr("Localizable", "price_amount_unit", fallback: "円")
  /// ￥
  internal static let priceAmountUnitMark = L10n.tr("Localizable", "price_amount_unit_mark", fallback: "￥")
  /// 単価
  internal static let priceUnit = L10n.tr("Localizable", "price_unit", fallback: "単価")
  /// ・広告を視聴して保存容量を3個追加することが可能です。
  internal static let rewordAddCapacity = L10n.tr("Localizable", "reword_add_capacity", fallback: "・広告を視聴して保存容量を3個追加することが可能です。")
  /// 広告を視聴できるのは1日に1回までです。
  internal static let rewordAlertMsg = L10n.tr("Localizable", "reword_alert_msg", fallback: "広告を視聴できるのは1日に1回までです。")
  /// 現在の容量：%@個
  internal static func rewordCapacity(_ p1: Any) -> String {
    return L10n.tr("Localizable", "reword_capacity_%@", String(describing: p1), fallback: "現在の容量：%@個")
  }
  /// 広告を視聴する
  internal static let rewordWatchAnAd = L10n.tr("Localizable", "reword_watch_an_ad", fallback: "広告を視聴する")
  /// List
  internal static let tabList = L10n.tr("Localizable", "tab_list", fallback: "List")
  /// Localizable.strings
  ///   Nenpi
  /// 
  ///   Created by t&a on 2025/01/07.
  internal static let tabNenpi = L10n.tr("Localizable", "tab_nenpi", fallback: "Nenpi")
  /// Price
  internal static let tabPrice = L10n.tr("Localizable", "tab_price", fallback: "Price")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
