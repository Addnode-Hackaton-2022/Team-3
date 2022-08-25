#
#  THIS NEED TO BE RUN ON THE RASPBERRY PI !!
#

# you need pymavlink installed - check documentation of how to install this
# (sudo pip install pymavlink)
#
# You also need to add MAVLINK20=1 in environment varibles
#

import time
from pymavlink import mavutil

# Start a connection listening on a UDP port
the_connection = mavutil.mavlink_connection('/dev/serial0', baud=921600)


# Wait for the first heartbeat 
the_connection.wait_heartbeat()
print("Heartbeat from system (system %u component %u)" % (the_connection.target_system, the_connection.target_component))

# method for changing message interval
def request_message_interval(message_id: int, frequency_hz: float):
    """
    Request MAVLink message in a desired frequency,
    documentation for SET_MESSAGE_INTERVAL:
        https://mavlink.io/en/messages/common.html#MAV_CMD_SET_MESSAGE_INTERVAL

    Args:
        message_id (int): MAVLink message ID
        frequency_hz (float): Desired frequency in Hz
    """
    the_connection.mav.command_long_send(
        the_connection.target_system, the_connection.target_component,
        mavutil.mavlink.MAV_CMD_SET_MESSAGE_INTERVAL, 0,
        message_id, # The MAVLink message ID
        1e6 / frequency_hz, # The interval between two messages in microseconds. Set to -1 to disable and 0 to request default rate.
        0, 0, 0, 0, # Unused parameters
        0, # Target address of message stream (if message has target address fields). 0: Flight-stack default (recommended), 1: address of requestor, 2: broadcast.
    )
    
# changing message intertval, 40 seams to be max :(
request_message_interval(mavutil.mavlink.MAVLINK_MSG_ID_ATTITUDE, 40)

# Gather data for 30
timeout = time.time() + 10
data = []
while True:
    # filter out other message type and only collect ATTITUDE
    data.append(the_connection.recv_match(blocking=True, type='ATTITUDE').to_dict())
    if time.time() > timeout:
        break

# uncomment this to print out the data
for d in data:
   print(d)
    
# print the amount of data
print(len(data))


# TODO: calculate the data

# TODO: steam the result data

