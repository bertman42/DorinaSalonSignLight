import logging
import logging.handlers

LOG_FILENAME="/home/pi/DSSL/DSSL.log"

# Set up a specific logger with our desired output level
my_logger = logging.getLogger('MyLogger')
my_logger.setLevel(logging.DEBUG)

# Add the log message handler to the logger
handler = logging.handlers.RotatingFileHandler(
              LOG_FILENAME, maxBytes=20, backupCount=5)

# create console handler and set level to debug
ch = logging.FileHandler(LOG_FILENAME)
ch.setLevel(logging.DEBUG)

# create formatter
formatter = logging.Formatter('%(asctime)-8s - %(name)s - %(levelname)s - %(message)s')

# add formatter to ch
ch.setFormatter(formatter)

# add ch to logger
my_logger.addHandler(ch)

# 'application' code
my_logger.info('Sunrise/Sunset time is: ')
