FROM ubuntu

RUN echo postfix postfix/mailname string noreply@localdeploy.local | debconf-set-selections
RUN echo postfix postfix/main_mailer_type string 'Satellite system' | debconf-set-selections
RUN apt update && apt install -y postfix mailutils

CMD service postfix start && tail
