# Serial Communication Protocol

Default transport:

```text
115200 baud
newline-terminated messages
```

Command:

```text
BASE,SHOULDER,ELBOW,PAN,TILT
```

Sensor packet:

```text
S,TEMPERATURE,HUMIDITY,DISTANCE1,DISTANCE2
```

Joint feedback:

```text
BASE,SHOULDER,ELBOW,PAN,TILT
```

These formats are derived from the supplied Processing interface.
