import os

class BillingEngine:
    def __init__(self):
        # รหัสลับถูกดึงจากตัวแปรในระบบ Cloud
        self.admin_code = os.getenv("ADMIN_ACCESS_CODE")
        self.clipscan_weight = 0.5 

    def verify_admin(self, code):
        return code == self.admin_code

    def calculate_cost(self, ai_tokens, ai_price):
        # รวมค่า Token AI และค่าธรรมเนียมระบบ ClipScan
        return (ai_tokens * ai_price) + (ai_tokens * self.clipscan_weight)
