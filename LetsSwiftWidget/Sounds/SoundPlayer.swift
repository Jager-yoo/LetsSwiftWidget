//
//  SoundPlayer.swift
//  LetsSwiftWidget
//
//  Created by 유재호 on 11/16/24.
//

import AVFoundation

final class SoundPlayer {

  static let shared = SoundPlayer()

  private init() {
    try? AVAudioSession.sharedInstance().setActive(true)
    try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
  }

  private var players: [Sound: AVAudioPlayer] = [:]

  func play(_ sound: Sound) {
    if players[sound] == nil {
      // 사운드 파일이 로드되지 않았으면 로드
      if let url = Bundle.main.url(forResource: sound.fileName, withExtension: "mp3") {
        players[sound] = try? AVAudioPlayer(contentsOf: url)
        players[sound]?.prepareToPlay()
      } else {
        print("⚠️ Sound file \(sound.fileName).mp3 not found")
        return
      }
    }

    guard let player = players[sound] else { return }

    if player.isPlaying {
      player.stop()
      player.currentTime = .zero // 사운드 시작점으로 이동
      player.prepareToPlay()
    }

    player.play()
  }

  enum Sound {
    case click
    case levelUp
    case notificationBeep
    case waterBeep
    case attention

    var fileName: String {
      switch self {
      case .click: return "click-sound"
      case .levelUp: return "level-up"
      case .notificationBeep: return "notification-beep"
      case .waterBeep: return "water-beep"
      case .attention: return "call-to-attention"
      }
    }
  }
}
