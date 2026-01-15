# Security Policy

## Supported Versions

Currently, we support the following versions with security updates:

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Reporting a Vulnerability

We take the security of our project seriously. If you discover a security vulnerability, please follow these steps:

### 🔒 Private Disclosure

**DO NOT** open a public issue for security vulnerabilities.

Instead, please report security vulnerabilities by:

1. **GitHub Security**: Use the [Security Advisories](https://github.com/DrRaspec/gamified_to_do_bloc/security/advisories) feature
2. **Include**:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

### Response Timeline

- **Initial Response**: Within 48 hours
- **Status Update**: Within 7 days
- **Fix Timeline**: Depending on severity
  - Critical: 1-7 days
  - High: 7-30 days
  - Medium: 30-90 days
  - Low: Best effort basis

### What to Expect

1. We will acknowledge receipt of your vulnerability report
2. We will investigate and validate the issue
3. We will develop and test a fix
4. We will release a security update
5. We will publicly disclose the vulnerability after the fix is released

### Bug Bounty

Currently, we do not have a bug bounty program. However, we deeply appreciate security researchers who help keep our users safe.

## Security Best Practices for Contributors

When contributing to this project, please follow these security practices:

### Environment Variables

- **Never** commit `.env` files
- **Never** commit API keys or tokens
- Use `.env.example` as a template
- Keep sensitive data in secure storage

### Authentication

- Store tokens in `flutter_secure_storage`
- Implement proper token refresh logic
- Never log sensitive information
- Use HTTPS for all API calls

### Dependencies

- Regularly update dependencies
- Review security advisories
- Use `flutter pub outdated` to check for updates
- Run `flutter pub upgrade --major-versions` carefully

### Code Review

- Review all pull requests for security issues
- Check for hardcoded credentials
- Verify proper input validation
- Ensure error messages don't expose sensitive info

## Known Security Considerations

### Current Implementation

- JWT tokens are stored in secure storage
- API calls use HTTPS
- Input validation on forms
- Error handling without exposing internals

### Future Improvements

- [ ] Implement certificate pinning
- [ ] Add biometric authentication
- [ ] Implement rate limiting on API calls
- [ ] Add end-to-end encryption for sensitive data
- [ ] Implement security headers
- [ ] Add automated security scanning

## Secure Configuration

### Required Security Setup

1. **API Configuration**

   ```dart
   // Always use HTTPS in production
   API_BASE_URL=https://your-secure-api.com
   ```

2. **Token Storage**

   - Already using `flutter_secure_storage`
   - Tokens encrypted at rest on device

3. **Network Security**
   ```yaml
   # Android: network_security_config.xml
   # iOS: Info.plist with App Transport Security
   ```

### Production Checklist

Before deploying to production:

- [ ] All API calls use HTTPS
- [ ] No hardcoded secrets in code
- [ ] Environment variables properly configured
- [ ] Debug mode disabled
- [ ] Logging of sensitive data removed
- [ ] Code obfuscation enabled (optional)
- [ ] Certificate pinning implemented (recommended)

## Contact

For security-related inquiries:

- GitHub Security: https://github.com/DrRaspec/gamified_to_do_bloc/security/advisories
- For general issues: Use GitHub Issues (non-security only)

Thank you for helping keep Gamified To-Do App and our users safe! 🔐
