import type { StrapiApp } from '@strapi/strapi/admin';

export default {
  config: {
    locales: [
      'ja',
      'zh-Hans',
      'en'
    ],
  },
  bootstrap(app: StrapiApp) {
    console.log(app);
  },
};
