FROM python:3-alpine

ARG VERSION

RUN pip install --no-cache nextcloud_news_updater==${VERSION}

ENTRYPOINT ["nextcloud-news-updater"]
