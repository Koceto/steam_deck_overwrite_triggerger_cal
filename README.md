# Steam Deck Trigger Calibration Overwriting Tool

Fork of [kasvtv's Steam Deck Trigger Calibration Overwriting Tool](https://github.com/kasvtv/steam_deck_overwrite_trigger_cal) that re-applies your custom trigger calibration automatically **at boot and after every resume from sleep**, because the Deck can reset it.

## What's different from the original

- No `PROCEED` prompt, no Steam kill and no "press A" step: the values you enter (or pipe in) are written immediately. This is what lets it run unattended.
- `src/auto_trigger_cal.sh` pipes your saved values into the tool.
- `src/auto_trigger_cal-resume.service` runs that script at boot and after resume.

> ⚠️ Because there is no confirmation step, pressing Enter at the prompts writes values right away (an empty answer keeps the current value). To only look at your current values, run `~/overwrite_trigger_cal` and press **Ctrl+C** at the first prompt.

## Find your values

Follow the [original project's guide](https://github.com/kasvtv/steam_deck_overwrite_trigger_cal) to find MAX/MIN values that work for your Deck: raise MAX in steps of about 20 and test in Gaming Mode under **Settings → Controller → Test Device Inputs**. Both triggers must read 0 when untouched.

## Install

In Desktop Mode, open Konsole.

1. Download the files to your home folder:

   ```bash
   cd ~
   curl -LO https://github.com/Koceto/steam_deck_overwrite_triggerger_cal/raw/master/output/overwrite_trigger_cal
   curl -LO https://raw.githubusercontent.com/Koceto/steam_deck_overwrite_triggerger_cal/master/src/auto_trigger_cal.sh
   curl -LO https://raw.githubusercontent.com/Koceto/steam_deck_overwrite_triggerger_cal/master/src/auto_trigger_cal-resume.service
   chmod +x overwrite_trigger_cal auto_trigger_cal.sh
   ```

2. Edit `~/auto_trigger_cal.sh` and replace the four values with yours.

3. Install and enable the service (needs your sudo password; set one with `passwd` if you haven't yet):

   ```bash
   sudo cp ~/auto_trigger_cal-resume.service /etc/systemd/system/
   sudo systemctl daemon-reload
   sudo systemctl reenable --now auto_trigger_cal-resume.service
   ```

   `reenable` also replaces the links left by older versions of this fork, whose service only ran after resume (or only at boot).

## Check that it works

```bash
journalctl -u auto_trigger_cal-resume.service --no-pager | tail -n 20
```

Each run logs the values it found before writing (`Current Left Trigger Cal: ...`) and ends with `Deactivated successfully`. Check once after a reboot and once after sleep.

## Uninstall

```bash
sudo systemctl disable auto_trigger_cal-resume.service
sudo rm /etc/systemd/system/auto_trigger_cal-resume.service
```

To go back to factory calibration, follow the restore instructions in the original project.

## Building

See [CONTRIBUTING.md](CONTRIBUTING.md).
