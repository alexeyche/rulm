#!/usr/bin/env python

import random
import json
import sys

train_ratio = float(sys.argv[1])
dst_train_file = sys.argv[2]
dst_val_file = sys.argv[3]


res = []
for l in sys.stdin:
	if l.strip():
		res.append(json.loads(l.strip()))

print(f"Read data {len(res)} records")

print("Shuffling data")
random.shuffle(res)


print(f"Splitting with train data ratio of {train_ratio}")
border = int(train_ratio * len(res))
train_records = res[:border]
val_records = res[border:]

print(f"Writing {len(train_records)} messages into {dst_train_file}")
with open(dst_train_file, "w") as w:
    for record in train_records:
        w.write(json.dumps({"messages": record, "source": "chat"}, ensure_ascii=False).strip() + "\n")

print(f"Writing {len(val_records)} messages into {dst_val_file}")
with open(dst_val_file, "w") as w:
    for record in val_records:
        w.write(json.dumps({"messages": record, "source": "chat"}, ensure_ascii=False).strip() + "\n")
