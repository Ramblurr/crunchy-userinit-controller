
FROM	python:3.12
Add /src /src
RUN pip install -r /src/requirements.txt
RUN adduser --system --no-create-home controller
USER controller
CMD ["kopf run /src/userinit.py --verbose"]
