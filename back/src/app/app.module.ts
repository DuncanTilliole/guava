import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MongooseModule } from '@nestjs/mongoose';
import { ArticlesModule } from 'src/apis/articles/articles.module';
import { PoliciesModule } from 'src/apis/policies/policies.module';
import { ContentsModule } from 'src/apis/contents/contents.module';
import { VersionsModule } from 'src/apis/versions/versions.module';

@Module({
  imports: [
    ConfigModule.forRoot(),
    ArticlesModule,
    ContentsModule,
    PoliciesModule,
    VersionsModule,
    MongooseModule.forRoot(process.env.MONGODB_URL)
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}