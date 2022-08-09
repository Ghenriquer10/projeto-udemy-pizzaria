import prismaClient from "../../prisma";
import { compare } from 'bcryptjs';
import { sign } from 'jsonwebtoken'

interface AuthRequest {
    email: string;
    password: string;
}

class AuthUserService {
    async execute({ email, password }: AuthRequest) {

        // Verificar se email exite
        const user = await prismaClient.user.findFirst({
            where: {
                email: email
            }
        })

        if (!user) {
            throw new Error("User/password incorrect!")
        }

        // Verificar se a senha está correta
        const passwordMatch = await compare(password, user.password)
        if (!passwordMatch) {
            throw new Error("User/password incorrect!")
        }

        // Se o login der certo é gerado o token de usuário

        const token = sign(
            {
                name: user.name,
                email: user.email
            },
            process.env.JWT_SECRET, {
            subject: user.id,
            expiresIn: '30d'
        }
        )

        return {
            id: user.id,
            name: user.name,
            email: user.email,
            token: token
        }
    }
}

export { AuthUserService }