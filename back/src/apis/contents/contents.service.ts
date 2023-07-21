import { Injectable } from '@nestjs/common';
import { CreateContentDto } from './dto/create-content.dto';
import { UpdateContentDto } from './dto/update-content.dto';

@Injectable()
export class ContentsService {
  async create(createContentDto: CreateContentDto) {
    return 'This action adds a new content';
  }

  async findAll() {
    return `This action returns all contents`;
  }

  async findOne(id: number) {
    return `This action returns a #${id} content`;
  }

  async update(id: number, updateContentDto: UpdateContentDto) {
    return `This action updates a #${id} content`;
  }

  async remove(id: number) {
    return `This action removes a #${id} content`;
  }
}
