# SMS Backup & Restore Prettify

A simple Ruby CLI tool that converts an XML backup from the [SMS Backup & Restore](https://play.google.com/store/apps/details?id=com.riteshsahu.SMSBackupRestore) Android application to pretty chatroom-esque text form.

## A few notes

* Requires the gem **nokogiri**
  * `gem install nokogiri`
* Written and tested for SMS Backup & Restore v7.46
* Only works for SMS, not MMS
  * Any MMS included in the backup are ignored
* I am completely willing to clean this up/add more features/convert this to a gem if there is actually a demand for it.
  * *(And I would be incredibly surprised if there was actually a demand for it.)*

## Usage

**Basic**

```bash
ruby sms_backup_restore_prettify.rb input_file.xml
```

**Limiting phone numbers in output**

```bash
ruby sms_backup_restore_prettify.rb input_file.xml 5555551234|5555551235
```

The last argument is an optional collection of numbers to include in the output, delimited by `|`. In the usage example above, only messages to/from the numbers *(555) 555-1234* and *(555) 555-1235* will be included in the output.

## Examples

### Basic

#### Input

```xml
<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
<!--File Created By SMS Backup & Restore v7.46 on 11/12/2015 18:00:00-->
<?xml-stylesheet type="text/xsl" href="sms.xsl"?>
<smses count="3">
  <sms protocol="0" address="(555) 555-1234" date="1420131600" type="2" subject="null" body="Hey, can you pick up milk on the way home?" toa="null" sc_toa="null" service_center="null" read="1" status="-1" locked="0" date_sent="0" readable_date="Jan 1, 2015 12:00:00 PM" contact_name="Jack Black" />
  <sms protocol="0" address="(555) 555-1234" date="1420131660" type="1" subject="null" body="Can do." toa="null" sc_toa="null" service_center="null" read="1" status="-1" locked="0" date_sent="0" readable_date="Jan 1, 2015 12:01:00 PM" contact_name="Jack Black" />
  <sms protocol="0" address="(555) 555-1234" date="1420131720" type="2" subject="null" body="Thanks!" toa="null" sc_toa="null" service_center="null" read="1" status="-1" locked="0" date_sent="0" readable_date="Jan 1, 2015 12:02:00 PM" contact_name="Jack Black" />
</smses>
```

```bash
ruby sms_backup_restore_prettify.rb test_inputs/test.xml
```

#### Output

```
Me [Jan 1, 2015 12:00:00 PM]
Hey, can you pick up milk on the way home?

Jack Black [Jan 1, 2015 12:01:00 PM]
Can do.

Me [Jan 1, 2015 12:02:00 PM]
Thanks!
```

===

### Limiting phone numbers in output

#### Input

```xml
<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
<!--File Created By SMS Backup & Restore v7.46 on 11/12/2015 18:00:00-->
<?xml-stylesheet type="text/xsl" href="sms.xsl"?>
<smses count="3">
  <sms protocol="0" address="(555) 555-1234" date="1420131600" type="2" subject="null" body="Hey, can you pick up milk on the way home?" toa="null" sc_toa="null" service_center="null" read="1" status="-1" locked="0" date_sent="0" readable_date="Jan 1, 2015 12:00:00 PM" contact_name="Jack Black" />
  <sms protocol="0" address="(555) 555-1234" date="1420131660" type="1" subject="null" body="Can do." toa="null" sc_toa="null" service_center="null" read="1" status="-1" locked="0" date_sent="0" readable_date="Jan 1, 2015 12:01:00 PM" contact_name="Jack Black" />
  <sms protocol="0" address="(555) 555-1234" date="1420131720" type="2" subject="null" body="Thanks!" toa="null" sc_toa="null" service_center="null" read="1" status="-1" locked="0" date_sent="0" readable_date="Jan 1, 2015 12:02:00 PM" contact_name="Jack Black" />
  <sms protocol="0" address="(555) 555-1236" date="1420131900" type="1" subject="null" body="Filter me, please." toa="null" sc_toa="null" service_center="null" read="1" status="-1" locked="0" date_sent="0" readable_date="Jan 1, 2015 12:05:00 PM" contact_name="Not Jack Black" />
</smses>
```

```bash
ruby sms_backup_restore_prettify.rb test_inputs/test_limit_senders.xml 5555551236
```

#### Output

```
Not Jack Black [Jan 1, 2015 12:05:00 PM]
Filter me, please.
```

## Contributing

1. Fork it ( https://github.com/mattantonelli/sms-backup-restore-prettify/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request