# Contributing to YokaKit_Replay

Thank you for your interest in contributing to YokaKit_Replay! This document outlines how to contribute effectively while maintaining constitutional compliance and project integrity.

## 🏗️ Project Overview

YokaKit_Replay is a repository modernization project that follows a strict constitutional framework:

- **Historical Fidelity**: Preserving and improving upon PinkieIt's commit history
- **Identity Preservation**: Maintaining YokaKit branding throughout (NON-NEGOTIABLE)
- **Sequential Phases**: Following structured development phases (0→1→2→3→4→5)
- **Quality First**: Implementing comprehensive testing and security measures

## 📋 Constitutional Requirements

### 🔒 Non-Negotiable Rules

1. **YokaKit Identity Preservation**: All user-facing elements must reference "YokaKit_Replay" or "YokaKit"
2. **No PinkieIt Branding**: User-facing files must not contain PinkieIt references (except in historical commit contexts)
3. **Phase Sequence**: Development must follow the established phase order
4. **Audit Trail**: All commits must reference related PinkieIt commit hashes when applicable

### 📖 Required Reading

Before contributing, please read:
- [`/memory/constitution.md`](../memory/constitution.md) - Project constitution
- [`README.md`](../README.md) - Project overview
- [`CLAUDE.md`](../CLAUDE.md) - Agent context and guidelines

## 🚀 Development Phases

### Phase 0: Repository Setup ✅
- GitHub repository infrastructure
- Branch protection and security scanning
- Issue templates and workflow automation
- Documentation structure

### Phase 1: Docker + Laravel (Upcoming)
- Docker environment establishment
- Laravel 10.x upgrade implementation
- Development environment standardization

### Phase 2: CI/CD Pipeline (Future)
- Comprehensive CI/CD pipeline construction
- Automated testing integration
- Deployment automation

### Phase 3: Testing & Quality (Future)
- Testing framework deployment
- Quality management system
- Code coverage and analysis

### Phase 4: WebSocket & MQTT (Future)
- WebSocket protocol modernization
- MQTT integration optimization
- Real-time communication enhancement

### Phase 5: Security & Performance (Future)
- Security hardening implementation
- Performance optimization
- Final quality assurance

## 🛠️ Getting Started

### Prerequisites

1. **GitHub Account** with access to w-pinkietech organization
2. **Git** configured with your GitHub credentials
3. **Understanding** of constitutional requirements
4. **Phase Lead Approval** for contributions to active phases

### Initial Setup

```bash
# Clone the repository
git clone git@github.com:w-pinkietech/Yokakit_Replay.git
cd YokaKit_Replay

# Initialize submodules
git submodule update --init --recursive

# Check current phase status
cat specs/001-implement-phase-0/tasks.md
```

## 📝 Contribution Process

### 1. Issue Creation

Use appropriate issue templates:
- **Bug Report**: [`bug-report.yml`](../.github/ISSUE_TEMPLATE/bug-report.yml)
- **Feature Request**: [`feature-request.yml`](../.github/ISSUE_TEMPLATE/feature-request.yml)
- **General Inquiry**: [`general-inquiry.yml`](../.github/ISSUE_TEMPLATE/general-inquiry.yml)

### 2. Branch Naming Convention

Follow the phase-based naming pattern:
```
phase-{N}-{feature-name}
hotfix/{issue-description}
docs/{documentation-update}
```

Examples:
- `phase-0-workflow-enhancement`
- `phase-1-docker-optimization`
- `hotfix/security-vulnerability`

### 3. Pull Request Process

1. **Create Feature Branch**
   ```bash
   git checkout -b phase-{N}-{feature-name}
   ```

2. **Make Changes** following quality standards

3. **Constitutional Compliance Check**
   - Verify YokaKit identity preservation
   - Ensure no PinkieIt references in user-facing files
   - Include PinkieIt commit reference in PR description

4. **Testing**
   ```bash
   # Run automated checks
   npm test (if applicable)
   composer test (if applicable)
   ```

5. **Create Pull Request** using the [PR template](../.github/pull_request_template.md)

6. **Code Review** by phase leads and maintainers

7. **Merge** after all checks pass and approvals obtained

## ✅ Quality Standards

### Code Quality Requirements

- **All automated checks must pass**: build, test, security scan, coverage, linting
- **Constitutional compliance verified**
- **Phase lead approval obtained**
- **Documentation updated** where necessary

### Required Status Checks

- `build-and-test`
- `security-scan-codeql`
- `dependency-check`
- `code-coverage`
- `lint-validation`
- `constitutional-compliance`

### Testing Standards

- **Unit tests** for new functionality
- **Integration tests** for cross-component features
- **Security tests** for security-sensitive changes
- **Performance tests** for optimization features

## 🔐 Security Guidelines

### Security Scanning

All contributions are automatically scanned using GitHub native tools:
- **CodeQL**: Static analysis for security vulnerabilities
- **Dependabot**: Dependency vulnerability detection
- **Secret Scanning**: Credential exposure prevention

### Security Best Practices

- Never commit secrets, API keys, or credentials
- Use environment variables for configuration
- Follow least privilege access principles
- Validate all inputs and sanitize outputs
- Review security implications of dependencies

## 👥 Team Structure & Permissions

### Phase-Based Teams

- **Phase 0 Leads**: Repository infrastructure and setup
- **Phase 1 Leads**: Docker and Laravel development
- **Phase 2 Leads**: CI/CD pipeline construction
- **Phase 3 Leads**: Testing and quality assurance
- **Phase 4 Leads**: WebSocket and MQTT development
- **Phase 5 Leads**: Security and performance optimization

### Review Requirements

- **Minimum 1 phase lead approval** for phase-specific changes
- **Repository admin approval** for constitutional changes
- **Security team review** for security-sensitive modifications

## 📚 Documentation Standards

### Documentation Requirements

- **Code comments** for complex logic
- **README updates** for new features
- **API documentation** for public interfaces
- **Constitutional compliance notes** for significant changes

### Documentation Structure

```
docs/
├── CONTRIBUTING.md         # This file
├── CODE_OF_CONDUCT.md     # Community guidelines
├── SECURITY.md            # Security policies
└── submodules/            # Submodule management
    ├── submodule-management.md
    └── synchronization-procedures.md
```

## 🔄 Submodule Management

### YokaKit Submodule

The YokaKit submodule contains core functionality:
- Update only during phase completions
- Maintain version synchronization
- Preserve constitutional alignment

### PinkieIt Submodule

The PinkieIt submodule provides historical context:
- Read-only reference for historical fidelity
- Source of truth for improvement extraction
- Never modify directly

### Synchronization Process

```bash
# Update submodules to latest
git submodule update --remote --merge

# Check submodule status
git submodule status

# Commit submodule updates
git add .gitmodules YokaKit pinkieit
git commit -m "chore: update submodules for phase completion

Constitutional compliance: Submodule synchronization
PinkieIt reference: {commit-hash}

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

## 🐛 Issue Reporting

### Bug Reports

When reporting bugs, include:
- **Environment details** (OS, browser, versions)
- **Steps to reproduce** the issue
- **Expected vs actual behavior**
- **Constitutional impact assessment**
- **Related PinkieIt commit** (if applicable)

### Feature Requests

When requesting features, consider:
- **Problem statement** and proposed solution
- **Target development phase**
- **Constitutional alignment**
- **Implementation considerations**

## 🚨 Emergency Procedures

### Hotfix Process

For critical issues requiring immediate attention:

1. **Create hotfix branch**: `hotfix/critical-issue-description`
2. **Use manual dispatch workflow** for emergency deployment
3. **Skip non-critical checks** only if absolutely necessary
4. **Document emergency justification**
5. **Follow up with proper testing** and documentation

### Constitutional Violations

If constitutional violations are discovered:

1. **Stop work immediately**
2. **Report to repository administrators**
3. **Document the violation** and proposed resolution
4. **Wait for constitutional review** before proceeding

## 🤝 Community Guidelines

### Code of Conduct

We follow the [Code of Conduct](CODE_OF_CONDUCT.md) to ensure a welcoming environment for all contributors.

### Communication Channels

- **GitHub Issues**: Bug reports and feature requests
- **Pull Request Reviews**: Code discussion and feedback
- **GitHub Discussions**: General project discussion
- **Security Issues**: Use GitHub security advisories

### Recognition

Contributors are recognized through:
- **GitHub contributor statistics**
- **Release notes acknowledgments**
- **Project documentation credits**
- **Phase completion recognition**

## 📞 Getting Help

### Support Resources

- **Documentation**: Check `/docs/` directory first
- **GitHub Issues**: Search existing issues before creating new ones
- **Phase Leads**: Contact appropriate phase leads for phase-specific questions
- **Repository Admins**: Contact for constitutional or access issues

### Mentorship

New contributors can request mentorship:
- **Pair programming sessions** with experienced contributors
- **Code review guidance** from phase leads
- **Constitutional compliance training**

---

## 📜 Constitutional Compliance Statement

This contributing guide maintains full compliance with the YokaKit_Replay constitution v1.1.0. All contributions must preserve YokaKit identity and follow sequential modernization phases while maintaining historical fidelity to PinkieIt improvements.

**Remember**: Quality first, constitutional compliance always, YokaKit identity preserved.

🤖 Generated with [Claude Code](https://claude.ai/code)
Co-Authored-By: Claude <noreply@anthropic.com>