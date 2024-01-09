import os

from google_sheets import google_sheets


class Flashcards:
    FLASHCARDS_SPREADSHEET_ID = os.environ["FLASHCARDS_SPREADSHEET_ID"]

    def pull(self) -> list[list[str]]:
        return google_sheets.get_data(self.FLASHCARDS_SPREADSHEET_ID)
