from fastapi import FastAPI, HTTPException, Header
import os
from src.billing.billing_manager import BillingEngine

app = FastAPI(title="ClipScan API Core")
billing = BillingEngine()

@app.post("/clipscan/{source_type}")
async def process_entry(source_type: str, data: str, api_key: str = Header(...)):
    # ระบบตรวจสอบรหัสผู้ใช้
    if not billing.verify_admin(api_key):
        raise HTTPException(status_code=403, detail="Invalid API Key")
        
    # ระบบแยกการทำงานตามประเภท (API, Video, Link)
    if source_type not in ["api", "video", "link"]:
        raise HTTPException(status_code=400, detail="Unknown source type")
        
    return {
        "status": "success",
        "system_id": "#AGI244",
        "processed_via": source_type,
        "data": data
    }
