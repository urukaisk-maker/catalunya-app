function basicAuth(req, res, next) {
  const header = req.headers.authorization || '';
  if (!header.startsWith('Basic ')) {
    res.set('WWW-Authenticate', 'Basic realm="Admin Catalunya"');
    return res.status(401).json({ error: 'Autenticacio requerida' });
  }
  const decoded = Buffer.from(header.slice(6), 'base64').toString('utf8');
  const [user, pass] = decoded.split(':');
  if (user !== process.env.ADMIN_USER || pass !== process.env.ADMIN_PASSWORD) {
    res.set('WWW-Authenticate', 'Basic realm="Admin Catalunya"');
    return res.status(401).json({ error: 'Credencials incorrectes' });
  }
  next();
}
module.exports = { basicAuth };
