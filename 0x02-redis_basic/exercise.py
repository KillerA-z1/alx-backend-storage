#!/usr/bin/env python3
"""
Cache class with Redis client and method call counter
"""

import redis
import uuid
from typing import Union, Callable, Optional
from functools import wraps


def count_calls(method: Callable) -> Callable:
    """
    Decorator to count how many times a method is called

    Args:
        method: The method to be decorated

    Returns:
        Callable: The wrapped method
    """
    @wraps(method)
    def wrapper(self, *args, **kwargs):
        """Wrapper function to increment the count and
        call the original method"""
        key = method.__qualname__
        self._redis.incr(key)
        return method(self, *args, **kwargs)
    return wrapper


def call_history(method: Callable) -> Callable:
    """
    Decorator to store the history of inputs and outputs for a function

    Args:
        method: The method to be decorated

    Returns:
        Callable: The wrapped method
    """
    @wraps(method)
    def wrapper(self, *args, **kwargs):
        """Wrapper function to store inputs and outputs in Redis"""
        input_key = f"{method.__qualname__}:inputs"
        output_key = f"{method.__qualname__}:outputs"

        self._redis.rpush(input_key, str(args))
        output = method(self, *args, **kwargs)
        self._redis.rpush(output_key, str(output))

        return output
    return wrapper


class Cache:
    def __init__(self):
        """Initialize the Redis client and flush the database"""
        self._redis = redis.Redis()
        self._redis.flushdb()

    @count_calls
    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
        Store the input data in Redis using a random key and return the key.

        Parameters:
            data (Union[str, bytes, int, float]): The data to store in Redis.

        Returns:
            str: The key under which the data is stored.
        """
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(
        self, key: str, fn: Optional[Callable] = None
    ) -> Union[str, bytes, int, float, None]:
        """
        Retrieve data from Redis and optionally convert it using a callable.

        Parameters:
            key (str): The key to retrieve from Redis.
            fn (Optional[Callable]): A callable to convert the data.

        Returns:
            Union[str, bytes, int, float, None]: The retrieved data or
            None if the key does not exist.
        """
        data = self._redis.get(key)
        if data is None:
            return None
        if fn is not None:
            return fn(data)
        return data

    def get_str(self, key: str) -> Optional[str]:
        """
        Retrieve a string from Redis.

        Parameters:
            key (str): The key to retrieve from Redis.

        Returns:
            Optional[str]: The retrieved string or
            None if the key does not exist.
        """
        return self.get(key, fn=lambda d: d.decode('utf-8'))

    def get_int(self, key: str) -> Optional[int]:
        """
        Retrieve an integer from Redis.

        Parameters:
            key (str): The key to retrieve from Redis.

        Returns:
            Optional[int]: The retrieved integer or
            None if the key does not exist.
        """
        return self.get(key, fn=int)
