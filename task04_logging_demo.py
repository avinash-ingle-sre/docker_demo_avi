#!/usr/bin/env python3
import logging
logging.basicConfig(filename='/tmp/task04_logging.log', level=logging.DEBUG, format='%(asctime)s [%(levelname)s] %(message)s')
logging.debug("debug msg")
logging.info("info msg")
logging.warning("warn msg")
logging.error("error msg")
print("Wrote logs to /tmp/task04_logging.log")
