import json

from kivy.app import App
from kivy.uix.label import Label

from flashcards import Flashcards


class FlashcardsApp(App):
    def build(self) -> Label:
        flashcards = Flashcards()
        data = flashcards.pull()
        return Label(text=json.dumps(data))


if __name__ == "__main__":
    FlashcardsApp().run()
