import base64
import json
import os
import typing as t

from google.oauth2 import service_account
from google.oauth2.service_account import Credentials
from googleapiclient.discovery import Resource
from googleapiclient.discovery import build


class GoogleSheets:
    GOOGLE_SCOPES: t.ClassVar = ["https://www.googleapis.com/auth/spreadsheets"]
    GOOGLE_SERVICE_ACCOUNT_JSON_B64: t.ClassVar = os.environ["GOOGLE_SERVICE_ACCOUNT_JSON_B64"]

    def __init__(self) -> None:
        self._service_account = None
        self._sheet = None

    @property
    def service_account(self) -> Credentials:
        if self._service_account is None:
            google_service_account_json = base64.b64decode(self.GOOGLE_SERVICE_ACCOUNT_JSON_B64).decode()
            info = json.loads(google_service_account_json)
            self._service_account = service_account.Credentials.from_service_account_info(
                info=info,
                scopes=self.GOOGLE_SCOPES,
            )
        return self._service_account

    @property
    def sheet(self) -> Resource:
        if self._sheet is None:
            service = build("sheets", "v4", credentials=self.service_account)
            self._sheet = service.spreadsheets()
        return self._sheet

    def get_data(self, spreadsheet_id: str, sheet_range: str = "Sheet1!A1:B2") -> list:
        result = self.sheet.values().get(spreadsheetId=spreadsheet_id, range=sheet_range).execute()

        return result.get("values", [])


google_sheets = GoogleSheets()
