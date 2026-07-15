#!/bin/bash
echo "--- กำลังตรวจสอบ Nginx ---"
systemctl status nginx | grep Active
echo "--- Log ล่าสุด 5 บรรทัด ---"
journalctl -u nginx --since "1 hour ago" | tail -n 5
