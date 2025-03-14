//
//  AudioPlayerManager.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/18/24.
//

import AVFoundation

class AudioPlayerManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
//class AudioPlayerManager: ObservableObject {
    
    var audioPlayer: AVAudioPlayer!
    
    @Published var isPreparedToPlay = false
    @Published var isPlaying = false
    @Published var playingAudioItem: (any AudioItem)? = nil
    @Published var progress: Float = 0.0
    
    
    private func prepareAndPlay(_ audioItem: any AudioItem) {
        
        guard let sound = Bundle.main.path(forResource: audioItem.filename, ofType: "mp3") else {
            print("Audio file could not be found.")
            return
        }
        
        let url = URL(fileURLWithPath: sound)
        
        stop()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying = true
            playingAudioItem = audioItem
            isPreparedToPlay = true
            startProgressMonitoring()
        } catch {
            print("An error occurred while trying to play audio: \(error)")
        }
    }
    
    func playOrPause(_ audioItem: any AudioItem) {
        
        if playingAudioItem?.id == audioItem.id, self.isPreparedToPlay, let player = audioPlayer {
            if player.isPlaying {
                pause()
            } else {
                play()
            }
        } else {
            self.prepareAndPlay(audioItem)
        }
    }
    
    func play() {
        audioPlayer?.play()
        isPlaying = true
    }

    func pause() {
        audioPlayer?.pause()
        isPlaying = false
    }

    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
        playingAudioItem = nil
        isPlaying = false
        isPreparedToPlay = false
        progress = 0.0
    }
    
    func isPlayingThis(_ audioItem: any AudioItem) -> Bool {
        return isPlaying && playingAudioItem?.id == audioItem.id
    }
    
    private func startProgressMonitoring() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            guard let self = self, let player = self.audioPlayer else {
                timer.invalidate()
                return
            }
            if self.isPlaying {
                let currentProgress = player.currentTime / player.duration
                self.progress = Float(currentProgress)
            }
        }
    }
    

    // AVAudioPlayerDelegate method to detect when playback finishes
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async {
            self.isPlaying = false
            self.progress = 0.0
        }
    }
}


