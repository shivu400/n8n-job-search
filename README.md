# Safe Automated Job Search & AI Scoring Workflow (n8n + Gemini Free Tier)

Designed specifically for **Nagendra M.P** (DevOps / SRE / Cloud / Backend / MLOps roles in Bengaluru & Remote).

---

## 📋 System Overview

```
[Schedule Trigger: 8 AM IST]
        │
        ▼
[Google Drive: Download Resume PDF]
        │
        ▼
[Extract Text from PDF]
        │
        ▼
[Google Gemini: Parse Resume into JSON Profile]
        │
        ├──────────────────────┬──────────────────────┐
        ▼                      ▼                      ▼
[Himalayas API]        [Jobicy Dev API]       [Arbeitnow API]  (+ Optional LinkedIn Guest)
        │                      │                      │
        └──────────────────────┼──────────────────────┘
                               ▼
            [Normalize & Aggregate Job Postings]
                               ▼
            [Google Sheets: Fetch Existing URLs]
                               ▼
            [Deduplicate: Keep Only Fresh Jobs]
                               ▼
            [Loop Over New Jobs (Batch Size: 1)]
                               ▼
            [Wait 2.5s (Stay under 15 RPM Free Tier)]
                               ▼
            [Gemini: Deep Technical Resume Match & Scoring]
                               ▼
            [Filter: Match Score >= 65/100]
                               │
            ┌──────────────────┴──────────────────┐
            ▼                                     ▼
[Log to Google Sheets Tracker]        [Skip / Archive Low Match]
            │
            ▼
[Collate Top 15 Matches Sorted by Score]
            │
            ▼
[Send Beautiful Daily HTML Digest via Gmail]
```

---

## 🛠️ Free Tech Stack & Zero-Cost Guarantee

| Component | Service | Cost | Rate Limit / Quota |
|---|---|---|---|
| **Automation Engine** | Self-Hosted n8n | Free / Open Source | Unlimited |
| **AI LLM** | Google Gemini 1.5 Flash (Google AI Studio) | 100% Free (No credit card needed) | 15 Requests/Min (RPM), 1 Million tokens/min |
| **Job Source 1** | Himalayas Public API | 100% Free (No API key / Public JSON) | Unlimited public reads |
| **Job Source 2** | Jobicy Remote Developer API | 100% Free (No API key / Public JSON) | 50 requests/hour |
| **Job Source 3** | Arbeitnow Jobs API | 100% Free (Public JSON) | Generous public tier |
| **Job Source 4 (Bengaluru)** | LinkedIn Guest API / Google Jobs RSS | 100% Free (No login needed) | Public rate limits |
| **Tracker** | Google Sheets | 100% Free | 300 requests/minute |
| **Notifications** | Gmail (OAuth2) | 100% Free | 500 emails/day |

---

## 📊 Google Sheets Tracker Schema

Create a Google Sheet titled `Job Search Tracker` with a tab named `Job Tracker`. Add these exact columns in row 1:

| Column A | Column B | Column C | Column D | Column E | Column F | Column G | Column H | Column I | Column J | Column K | Column L | Column M | Column N |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **Date Found** | **Job Title** | **Company** | **Location** | **Remote** | **Match Score** | **Matched Skills** | **Missing Skills** | **Why It Fits** | **Red Flags** | **Suggested Opening** | **Job URL** | **Source** | **Status** |

> **Status Dropdown values:** `To Review`, `Applied`, `Interviewing`, `Rejected`, `Offer`, `Skipped`.

---

## 🚀 Setup & Import Steps

1. **Import the Workflow into n8n:**
   - In n8n, click **Workflows** -> **Import from File**.
   - Select `d:/n8n workflow/job_search_automation.json`.

2. **Configure Credentials in n8n:**
   - **Google Gemini API Key:** Go to [Google AI Studio](https://aistudio.google.com/), generate a free API key, and add it either as an n8n Environment Variable `GEMINI_API_KEY` or replace `YOUR_GEMINI_API_KEY` in the HTTP nodes.
   - **Google Drive & Sheets:** In n8n, create a `Google OAuth2` credential authorized for Drive & Sheets.
   - **Gmail:** Create a `Gmail OAuth2` credential for sending your daily digest.

3. **Provide Resume & Sheet IDs:**
   - In **Download Resume PDF**, set your Google Drive PDF File ID.
   - In **Read Existing Tracker Sheet** and **Log Job to Google Sheets**, select your `Job Search Tracker` sheet.
   - In **Send Gmail Daily Digest**, enter your email address.

4. **Activate the Workflow:**
   - Toggle the workflow to **Active**. It will run automatically every morning at 8:00 AM IST!
