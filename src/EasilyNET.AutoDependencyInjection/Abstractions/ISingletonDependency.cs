using EasilyNET.AutoDependencyInjection.Attributes;
using Microsoft.Extensions.DependencyInjection;

namespace EasilyNET.AutoDependencyInjection.Abstractions;

/// <summary>
/// 实现此接口的类型将自动注册为<see cref="ServiceLifetime.Singleton" /> 模式
/// </summary>
[IgnoreDependency]
public interface ISingletonDependency { }