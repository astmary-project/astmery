import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()

async function main() {
    await prisma.character.create({
        data: {name: 'Tiliacile', stats: {HP: 10, MP: 10}}
    })
}

main().catch(console.error).finally(async () => prisma.$disconnect())