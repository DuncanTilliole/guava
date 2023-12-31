import { NestFactory } from '@nestjs/core';
import { AppModule } from './app/app.module';
import { ValidationPipe } from '@nestjs/common';
import { join } from 'path';
import * as express from 'express';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  
  app.use('/', express.static(join(__dirname, '..', 'public')));
  app.useGlobalPipes(new ValidationPipe({ whitelist: true }));

  await app.listen(process.env.APP_PORT);
}
bootstrap();