FROM registry.access.redhat.com/ubi9/python-312:1-25.1725851348
RUN pip install --no-cache-dir -r messing-with-models/requirements.txt
RUN git clone https://github.com/eformat/messing-with-models.git
COPY developers-redhat-com.sh developers-redhat-com.sh
