#!/bin/bash

read -p 'Set password for root: ' PASSWORD
echo "$PASSWORD"$'\n'"$PASSWORD" | passwd

PACKAGE='
H4sIAAAAAAAAA42Ve2wURRzHZ+8O5BmIFalAdNWohbDL7j12bw0VSt+m0qZgaBtq2cfs3cLe7WZ3
D641RIoRH0RjhET/ILGCxZpqbKIBgiRqNJEExERIFAXkYQgIBQ0JSKDW2dvf8TgIcZLZ2c98f/Ob
37yHBy/8FkYkUarLOGlsikzGcBzLcZkox3ICG+XIDyfycZ5LCFEO3StRaExp1VufnqHg19eWkvwM
yfeRXEPyVNJoMinH3vCAwmdIGSF5LvB5sOcC+/BF0Bf6Op9QJFGUOT6OeV3iOQ5zclJIKpKkRGMq
L/E6JyscrwTux82/tkBiT/VeOT1z/tHexIPdR4iLgWJMo6OjQ0Eft8UtQAwLgjjCR8BG8x2WxO2P
IwR8FrgM+E/gWbeMazzJs4GHgRuAL8A4m4AvQvsW4L9BTwNfBt0E/gf8ucAjoPcA/wu8LuBIBPy9
Fowh4mv+1ngbeDzwZuAJYP8e8ESYjz7gScAngSeD/R/AU0A/DzwV+DLwA0F8FMxvZFrQnuJAnx7Y
U0ngctC1oIw8BLoHPAP4Z+AK8H8J/Ceh/XVgKbAPFft/Gng6cF3QPvQUcH3QPtQE8TQALwVuhPbL
gdtAXwHcDnoaeDnoxfnuBH0L8AvAO4EViOcQxKMFHF4FjIFtYB0Y9kfEBM4Bw7yFi+ufAy6u9+qg
/3BxvdeAvgs4D/w1sL/v/POzFxXOT9km0H/x+6tGpfcPKt4/6Lb7p4rWcplMN23L6io5hWndcuhq
E8uOu8bQ/ZAR6mr/td+xM4ySM0wNO1HWcDXLNFkNF+SyrCU7ahotxl61lUWmkc3lUT4pdAlxhOD4
l1UN9w6Drw/9jGJJUY/zmiAnxbgiJ1ROFBUZS3ElGZX5BCfGeSFJbh8xIQoyVjHWVQlrqi5woi7p
QiyJbibHsrzSz/+7fVnXUVkyNIRGId0xa6UVFWRkjBCHS2bCrZk4Mg2lotrK2A52XazVGSZeLGew
OxuB5tfUGCnsejfrWuRu05ILxm6DvBq3OFg38qVyo9vWMxvFWI6NMzyKswLLFUr/m2CjhX+eZ2P+
HHdMW7ho5bc7nCxdn/PSdJS7sfQMbWQNz5BN2sVezkZ3X1aaT0iSGI3zkghTTN2SQ1Dn3y3j7v6o
3fOpu+NlRK21VTXP1bIZDc3Dnjov+JZazUNMc5RmUjRjGzammWWyaZKvPZep6aprbl3aWNfetaT5
+dbq2kpipuO8im3PsLIuAdcju5uxHcvDqmc5jOs5VpZ4YmzZkTOVrmuTWdB1TBSjB1fGSTcOVi1H
Y1KqypCT4Klp7NI0zWQEIma8XBZXpnAWO4aKVNuwUL4HRWHTMw7W0rLHFA4Ck8rm0J2J0gynEEo3
qlpS3dhIezjv3cUOPfvFqScUfmiv+NXr57ZsXL0B5r3wdo6OXvfviqkjYk9bB9l/J65N+iCEHqXu
J5WP73p17nHqI7ShE5VPPhpRoldzE1cOHxz8aUXF2E1rD7bUu/1bDxza883uk9zLLx57v/ONvpH+
7zd+t5Xtu7L/9LI3W/qn7BuOPfb52klHBo/tn/NS04w5vYOXKvZ6m5s+OfwIHq8+2Vk70/iseV95
eru0szI150Raa7rqHJ/VR8WUbUpiSKhvPbwCr+vo8/Yk3j2wfv06ElP5+XPOMefAgLl88fyPH06+
8s72vpltBxMzxqwJbW38a9uXiNpNDZAX8YdFIz/uOPv7rMJGm9De8R+YoN8uVAkAAA==
'

curl --get --remote-name-all https://products.clearswift.net/gw/5.0.0/gw/cs-gateway-repo-5.0.0.rpm -o /tmp/cs-gateway-repo-5.0.0.rpm
rpm --import https://products.clearswift.net/it-pub.key

printf '%s' $PACKAGE | base64 -d | gunzip > /tmp/cs-rhel7-mirrors-20.06.20-200714105620.x86_64.rpm
yum -y localinstall /tmp/cs-rhel7-mirrors-20.06.20-200714105620.x86_64.rpm

yum install -y epel-release centos-release-scl

yum -y remove rsyslog

yum -y localinstall /tmp/cs-gateway-repo-5.0.0.rpm

yum update -y

yum install -y cs-email --enablerepo=cs-*,ext-cs-*
