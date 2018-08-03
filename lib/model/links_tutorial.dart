import 'dart:convert';

class LinksTutorial {
  int tutorialId;
  String title;
  String description;
  String source;

  LinksTutorial(this.tutorialId, this.title, this.description, this.source);

  Map toJSON() {
    return {
      "tutorialId": this.tutorialId,
      "title": this.title,
      "description": this.description,
      "source": this.source
    };
  }
}
