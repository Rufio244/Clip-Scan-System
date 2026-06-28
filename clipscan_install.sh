#!/bin/bash
# ระบบติดตั้ง ClipScan API Platform (Security Optimized)

echo "กำลังติดตั้งระบบ ClipScan API..."

# 1. สร้างโครงสร้างหลัก
mkdir -p src/api src/billing src/modules

# 2. สร้าง Billing Manager (อ่านรหัสจาก Environment Variable)
cat <<EOF > src/billing/billing_manager.py
import os

class BillingEngine:
    def __init__(self):
        # รหัสผ่านจะถูกอ่านจากระบบภายนอก (ไฟล์ .env)
        self.admin_code = os.getenv("ADMIN_ACCESS_CODE")
        self.clipscan_weight = 0.5

    def verify_admin(self, code):
        if code != self.admin_code:
            raise PermissionError("Access Denied!")
        return True

    def calculate_total(self, ai_tokens, ai_price, user_id):
        return (ai_tokens * ai_price) + (ai_tokens * self.clipscan_weight)
EOF

# 3. สร้างไฟล์ .env.example (เพื่อให้ผู้ใช้รู้ว่าต้องใส่รหัสที่ไหน)
cat <<EOF > .env.example
# ใส่รหัสของคุณที่นี่ แล้วเปลี่ยนชื่อไฟล์เป็น .env
ADMIN_ACCESS_CODE=#AGI244
EOF

echo "ติดตั้งระบบเสร็จสิ้น!"
echo "กรุณาสร้างไฟล์ .env และกำหนดค่า ADMIN_ACCESS_CODE ก่อนเริ่มใช้งาน"
