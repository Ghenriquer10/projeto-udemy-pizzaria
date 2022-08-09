import { Request, Response, NextFunction } from 'express'
import { verify } from 'jsonwebtoken';

interface Payload {
    sub: string
}

export function isAuthenticated(
    req: Request,
    res: Response,
    next: NextFunction
) {
    // Recebendo o token ao realizar uma rota privada
    const authToken = req.headers.authorization

    if (!authToken) {
        return res.status(401).end();
    }

    const [, token] = authToken.split(" ")


    try {
        const { sub } = verify(
            token,
            process.env.JWT_SECRET
        ) as Payload;

        // Recuperando o id do token e inserindo em uma variável dentro do request
        req.user_id = sub;

        return next();

    } catch (err) {
        return res.status(401).end()
    }
}