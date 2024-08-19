class Constants {

  static const imageUrl = 'https://firebasestorage.googleapis.com/v0/b/spotifyzzd.appspot.com/o/covers%2F';
  static const audioUrl = 'https://firebasestorage.googleapis.com/v0/b/spotifyzzd.appspot.com/o/songs%2F';

  static String setImage (String image) {
    String setImage = '$imageUrl$image?alt=media';
    return setImage;
  }

  static String setAudio (String audio){
    String setAudio = '$audioUrl$audio?alt=media';
    return setAudio;
  }

  static String formatDuration (Duration duration){
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return'${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }
}
