import { Test, TestingModule } from '@nestjs/testing';
import { ContentsController } from '../../../apis/contents/contents.controller';
import { ContentsService } from '../../../apis/contents/contents.service';

describe('ContentsController', () => {
  let controller: ContentsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ContentsController],
      providers: [ContentsService],
    }).compile();

    controller = module.get<ContentsController>(ContentsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
