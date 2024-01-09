from kivy.app import App
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.label import Label

from flashcards import Flashcards


class FlashcardsLayout(FloatLayout):
    HEADS = 0
    TAILS = 1
    DEFAULT_TEXT = "NO MORE FLASHCARDS"

    def __init__(self, **kwargs) -> None:
        self.flashcards = kwargs.pop("flashcards")
        super().__init__(**kwargs)
        self.current_flashcard_idx = 0
        self.build()

    def _set_flashcard(self, state: int) -> None:
        self.ids.flashcard.text = self.flashcards[self.current_flashcard_idx][state]

    def next_flashcard(self) -> None:
        self.current_flashcard_idx += 1
        try:
            self._set_flashcard(self.HEADS)
        except IndexError:
            self.current_flashcard_idx = 0
            self._set_flashcard(self.HEADS)

    def reveal_flashcard(self) -> None:
        self._set_flashcard(self.TAILS)

    def build(self) -> None:
        self._set_flashcard(self.HEADS)


class FlashcardsApp(App):
    def build(self) -> Label:
        flashcards = Flashcards()
        flashcards_data = flashcards.pull()
        return FlashcardsLayout(flashcards=flashcards_data)


if __name__ == "__main__":
    FlashcardsApp().run()
