FROM perl:5.26.0

RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Carton

RUN apt-get -qq update \
 && apt-get install -y ffmpeg libimage-exiftool-perl libav-tools imagemagick handbrake-cli \
 && apt-get clean

WORKDIR /app

COPY cpanfile /app
COPY media-scanner.pl /app

RUN carton install

ENTRYPOINT ["carton","exec","/app/media-scanner.pl"]
