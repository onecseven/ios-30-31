//
//  Color.swift
//  timer0.1
//
//  Created by Tatiana Talavera on 12-06-23.
//

import Foundation

struct Color {
  let light: String
  let medium: String
  let dark: String
}

struct Colors {
  let gray = Color(light: "#d0d5db", medium: "#9aa3b0", dark: "#637383")
  let orange = Color(light: "#fdccae", medium: "#ef925a", dark: "#e15806")
  let blue = Color(light: "#abddff", medium: "#56a7df", dark: "#0071bf")
  let green = Color(light: "#e5d8ab", medium: "#c0b87f", dark: "#9a9753")
  let red = Color(light: "#fcb2b6", medium: "#ef5e66", dark: "#e10915")
  let violet = Color(light: "#d7bdff", medium: "#b482ff", dark: "#9147ff")
  let yellow = Color(light: "#f4de9d", medium: "#e8c44f", dark: "#dcaa00")
  let forest = Color(light: "#b6edba", medium: "#6dc173", dark: "#24942b")
  let purple = Color(light: "#efa2e8", medium: "#be5eb5", dark: "#8c1982")
  let pink = Color(light: "#e1c0c9", medium: "#cb98a3", dark: "#b46f7c")
  let aqua = Color(light: "#94ffed", medium: "#4ac1ad", dark: "#00826c")
}

let TimerColors: Colors = Colors()
