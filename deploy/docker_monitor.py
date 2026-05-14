#!/usr/bin/env python3
import subprocess
import time

# This uses the activity light on the Pi and overwrites the default behavior
LED_TRIGGER = "/sys/class/leds/ACT/trigger"
LED_BRIGHTNESS = "/sys/class/leds/ACT/brightness"


def set_led(value: int):
    """Set the brightness value of the LED"""
    with open(LED_BRIGHTNESS, "w") as f:
        f.write(str(value))


def take_led_control():
    """Overwrites the default behavior"""
    with open(LED_TRIGGER, "w") as f:
        f.write("none")


def container_status() -> str:
    """Returns the container status as starting, running, or stopped"""
    try:
        # Docker status first
        result = subprocess.run(
            ["docker", "inspect", "--format", "{{.State.Status}}", "worms-ros"],
            capture_output=True,
            text=True,
            timeout=5,
        )
        state = result.stdout.strip()

        # If it is running, also check if the file exists so we know if it in startup
        if state == "running":
            ready = subprocess.run(
                ["docker", "exec", "worms-ros", "test", "-f", "/home/worms-ws/.ready"],
                capture_output=True,
                timeout=5,
            )
            return "running" if ready.returncode == 0 else "starting"
        elif state == "restarting":
            return "starting"
        else:
            return "stopped"

    except subprocess.TimeoutExpired:
        return "starting"
    except Exception:
        return "stopped"


def main():
    take_led_control()
    set_led(0)

    blink_state = False

    while True:
        status = container_status()

        if status == "running":
            set_led(1)
            time.sleep(2)

        elif status == "starting":
            blink_state = not blink_state
            set_led(1 if blink_state else 0)
            time.sleep(0.5)

        elif status == "stopped":
            set_led(0)
            time.sleep(2)


if __name__ == "__main__":
    main()
